# Use the official Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set environment variables for powershell execution policy
SHELL ["powershell", "-Command"]

# Install necessary tools
RUN Invoke-WebRequest -Uri "https://raw.githubusercontent.com/hudahadoh/winrust/main/down.bat" -OutFile "Downloads.bat" ; \
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c Downloads.bat" -Wait ; \
    Remove-Item -Force "Downloads.bat"

# Copy local scripts to the container
COPY show.bat C:/show.bat
COPY time.py C:/time.py

# Set the working directory
WORKDIR C:/

# Run AnyDesk login script
RUN Start-Process -FilePath "cmd.exe" -ArgumentList "/c show.bat" -Wait

# Run the time counter script
CMD ["python", "time.py"]
