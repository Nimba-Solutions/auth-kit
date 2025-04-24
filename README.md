# auth-kit

AuthKit is an open source unlocked package for Salesforce that streamlines the management of authentication and credential configurations through Lightning Web Components and Apex. This toolkit simplifies the administration of NamedCredential, ExternalCredential, AuthProvider, and related metadata types, eliminating the need for repetitive configuration tasks.

Designed for Salesforce developers and administrators, AuthKit provides user-friendly UX, API, and CICD interfaces to create, manage, and deploy credential configurations across orgs. The package reduces implementation time for integrations by offering reusable components and standardized patterns for secure authentication management.


## Contributing

### To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `cci org browser dev` to open the org in your browser.

### To contribute to on this project on github:

1. Prepare your changes in a `feature/*` branch
2. Submit a Pull Request to the `main` branch


# Credit

This project was partially inspired by [this excellent gist](./Populating%20Credentials%20with%20the%20Connect%20API.md) by GitHub user [rossbelmont](https://gist.github.com/rossbelmont).
