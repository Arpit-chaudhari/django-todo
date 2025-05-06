# 1. Use an official Python image
FROM python:3.12-slim

# 2. Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set working directory inside the container
WORKDIR /app

# 4. Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# 5. Copy project files
COPY . /app/

# 6. Run the server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
