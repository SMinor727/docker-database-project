1) Clone this repository by entering "git clone https://github.com/SMinor727/docker-database-project.git" into your terminal
2) Enter into the terminal "docker compose up" to start running a copy of the database in DockerDesktop
     2a) You can open DockerDesktop to make sure that the container is up and running
3) Enter "docker exec -it event_feedback_db psql -U postgres -d event_feedback" into the terminal to connect to the database
4) To exit the database, type "\q"
5) To close the database from the terminal, enter "docker compose down"
     5a) In DockerDesktop, click the "Stop" action
