# Use the official Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set environment variables for powershell execution policy
SHELL ["powershell", "-Command"]

# Install necessary tools by downloading and running the Downloads.bat script
RUN Invoke-WebRequest -Uri "https://raw.githubusercontent.com/hudahadoh/winrust/main/down.bat" -OutFile "C:\\Downloads.bat" ; \
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c C:\\Downloads.bat" -Wait ; \
    Remove-Item -Force "C:\\Downloads.bat"

# Copy local scripts to the container
COPY show.bat C:\\show.bat
COPY time.py C:\\time.py

# Set the working directory
WORKDIR C:\\

# Run AnyDesk login script
RUN Start-Process -FilePath "cmd.exe" -ArgumentList "/c C:\\show.bat" -Wait

# Set the entrypoint to run the time counter script
ENTRYPOINT ["python", "C:\\time.py"]
