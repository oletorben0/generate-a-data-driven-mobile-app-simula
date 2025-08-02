# API Specification for Data-Driven Mobile App Simulator

# Load necessary libraries
library(plumber)
library=jsonlite)
library(random)

# Define API Endpoints

# 1. GET /devices
# Returns a list of available device types (e.g. iPhone, Samsung, etc.)
get_devices <- function() {
  devices <- c("iPhone", "Samsung", "Google Pixel", "OnePlus")
  return(list(devices = devices))
}

# 2. GET /apps
# Returns a list of available app types (e.g. social media, games, etc.)
get_apps <- function() {
  apps <- c("Social Media", "Games", "Productivity", "Entertainment")
  return(list(apps = apps))
}

# 3. POST /simulate
# Simulates user interaction with a mobile app
simulate_interaction <- function(req) {
  # Extract request body
  body <- jsonlite::fromJSON(req$postBody)
  device <- body$device
  app <- body$app
  interaction_type <- body$interaction_type
  
  # Generate simulated data
  data <- list(
    device = device,
    app = app,
    interaction_type = interaction_type,
    timestamp = Sys.time(),
    user_id = paste0("user_", sample(1:100, 1)),
    session_id = paste0("session_", sample(1:100, 1))
  )
  
  # Return simulated data
  return(list(data = data))
}

# Create API
api <- plumb("api")

# Add API Endpoints
api$GET("/devices", get_devices)
api$GET("/apps", get_apps)
api$POST("/simulate", simulate_interaction)

# Run API
api$run()