# Build
mvn clean package && docker build -t com.airhacks/eclipsefish .

# RUN

docker rm -f eclipsefish || true && docker run -d -p 8080:8080 -p 4848:4848 --name eclipsefish com.airhacks/eclipsefish 