# For more information, please refer to https://aka.ms/vscode-docker-python
FROM ubuntu:18.04

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Update and install dependencies
RUN apt-get -y update \
    && apt-get -y install ffmpeg \
    && apt-get -y install python3 \
    && apt-get -y install python3-pip

# Install pip requirements
ADD requirements.txt .
RUN python3 -m pip install -r requirements.txt

WORKDIR /music_bot
ADD . ./

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
RUN useradd appuser && chown -R appuser /music_bot
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python3", "-m", "music_bot", "config.ini"]
