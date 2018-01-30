# web-server-container

Steps to build and run (on your VPS or wherever):

1. You should have following structure in src:
    ```
    └── src
        └── static
            ├── css
            ├── font
            └── js
    
    ```
2. Run: `docker build --tag reflectcal/web-server .`