#!/usr/bin/env python3
import json
import os
import sys

# Define paths
repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
metadata_types_dir = os.path.join(repo_root, 'metadata', 'types')
force_app_path = os.path.join(repo_root, 'force-app', 'main', 'default')

# Color codes for terminal output
RED = '\033[91m'
GREEN = '\033[92m'
YELLOW = '\033[93m'
RESET = '\033[0m'

def get_valid_metadata_types():
    """Get valid metadata types from the metadata/types directory."""
    if not os.path.exists(metadata_types_dir):
        print(f"{YELLOW}Warning: metadata/types directory not found at {metadata_types_dir}. Using fallback list.{RESET}")
        # Fallback list of common Salesforce metadata types
        return {
            "aura", "lwc", "classes", "objects", "layouts", "tabs", "permissionsets", 
            "profiles", "staticresources", "triggers", "pages", "components", 
            "applications", "flows", "contentassets", "flexipages", "labels",
            "externalCredentials", "namedCredentials", "remoteSiteSettings"
        }
    
    valid_types = set()
    for filename in os.listdir(metadata_types_dir):
        if filename.endswith('.json'):
            # Remove .json extension to get the type name
            type_name = filename[:-5]
            valid_types.add(type_name)
    
    return valid_types

def normalize_directory_name(name):
    """Convert directory name to match metadata type format."""
    # Common conversions map
    conversions = {
        "class": "ApexClass",
        "classes": "ApexClass",
        "object": "CustomObject",
        "objects": "CustomObject",
        "trigger": "ApexTrigger",
        "triggers": "ApexTrigger",
        "layout": "Layout",
        "layouts": "Layout",
        "permissionset": "PermissionSet",
        "permissionsets": "PermissionSet",
        "profile": "Profile",
        "profiles": "Profile",
        "component": "ApexComponent",
        "components": "ApexComponent",
        "page": "ApexPage",
        "pages": "ApexPage",
        "application": "CustomApplication",
        "applications": "CustomApplication",
        "customobject": "CustomObject",
        "customobjects": "CustomObject",
        "workflow": "Workflow",
        "workflows": "Workflow",
        "workskillrouting": "WorkSkillRouting",
        "workskillroutings": "WorkSkillRouting",
        "externalcredential": "ExternalCredential",
        "externalcredentials": "ExternalCredential",
        "namedcredential": "NamedCredential",
        "namedcredentials": "NamedCredential",
        "remotesitesetting": "RemoteSiteSetting",
        "remotesitesettings": "RemoteSiteSetting",
        "staticresource": "StaticResource",
        "staticresources": "StaticResource"
    }
    
    # Try direct conversion
    lower_name = name.lower()
    if lower_name in conversions:
        return conversions[lower_name]
    
    return name

def is_valid_metadata_type(directory_name, valid_types):
    """Check if a directory corresponds to a valid metadata type."""
    # Normalize the directory name
    normalized_name = normalize_directory_name(directory_name)
    
    # Check for direct match
    if normalized_name in valid_types:
        return True
    
    # Case-insensitive match
    for valid_type in valid_types:
        if valid_type.lower() == normalized_name.lower():
            return True
    
    return False

def validate_force_app_structure():
    """Validate the structure of force-app/main/default directory."""
    valid_types = get_valid_metadata_types()
    
    if not os.path.exists(force_app_path):
        print(f"{YELLOW}Warning: force-app/main/default directory not found at {force_app_path}.{RESET}")
        return True
        
    print(f"Checking directories in {force_app_path}...")
    
    has_errors = False
    invalid_dirs = []
    valid_dirs = []
    
    # Get all directories in force-app/main/default
    for item in os.listdir(force_app_path):
        item_path = os.path.join(force_app_path, item)
        if os.path.isdir(item_path):
            if is_valid_metadata_type(item, valid_types):
                print(f"{GREEN}✓ {item} - Valid metadata type{RESET}")
                valid_dirs.append(item)
            else:
                print(f"{RED}✗ {item} - Invalid metadata type{RESET}")
                has_errors = True
                invalid_dirs.append(item)
    
    # Print summary
    print("\n=== Validation Summary ===")
    print(f"Total directories checked: {len(valid_dirs) + len(invalid_dirs)}")
    print(f"Valid directories: {len(valid_dirs)}")
    print(f"Invalid directories: {len(invalid_dirs)}")
    
    if invalid_dirs:
        print("\nInvalid directories found:")
        for dir_name in invalid_dirs:
            print(f"  - {dir_name}")
    
    # Set outputs for GitHub Actions
    if os.environ.get('GITHUB_ACTIONS') == 'true':
        with open(os.environ.get('GITHUB_OUTPUT', '/dev/null'), 'a') as f:
            f.write(f"has_errors={str(has_errors).lower()}\n")
            f.write(f"invalid_dirs={json.dumps(invalid_dirs)}\n")
            f.write(f"valid_dirs={json.dumps(valid_dirs)}\n")
    
    return not has_errors

if __name__ == "__main__":
    print("Validating force-app metadata structure...")
    if not validate_force_app_structure():
        print(f"{RED}Validation failed! Some directories in force-app/main/default are not valid Salesforce metadata types.{RESET}")
        sys.exit(1)
    else:
        print(f"{GREEN}Validation successful! All directories in force-app/main/default are valid Salesforce metadata types.{RESET}")
        sys.exit(0) 