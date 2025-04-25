#!/usr/bin/env python3
import json
import os
import sys

# Get the directory where the script is located
script_dir = os.path.dirname(os.path.abspath(__file__))

# Input file and output directory
json_file = os.path.join(script_dir, "metadata-coverage.json")
output_dir = os.path.join(script_dir, "types")

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

print(f"Extracting metadata types from {json_file}...")

# Check if the file exists
if not os.path.isfile(json_file):
    print(f"Error: File not found: {json_file}")
    sys.exit(1)

try:
    # Read the JSON file
    with open(json_file, 'r') as f:
        data = json.load(f)
    
    # Check if the 'types' key exists
    if 'types' not in data:
        print("Error: No 'types' key found in the JSON file")
        sys.exit(1)
    
    # Extract each metadata type to its own file
    count = 0
    for key, value in data['types'].items():
        # Create a sanitized filename
        safe_key = key.replace('/', '_').replace('\\', '_').replace(' ', '_')
        filename = os.path.join(output_dir, f"{safe_key}.json")
        
        # Save the individual type to its own file
        with open(filename, 'w') as f:
            json.dump(value, f, indent=2)
        
        print(f"Extracted {key}")
        count += 1
    
    print(f"Done! {count} metadata types extracted to {output_dir}/")

except json.JSONDecodeError:
    print("Error: Invalid JSON file")
    sys.exit(1)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1) 