package main

import (
    "fmt"
    "net/http"
    "time"
)

func countdownHandler(w http.ResponseWriter, r *http.Request) {
    mst := time.FixedZone("MST", -7*60*60)
    timestamp := time.Date(2024, time.November, 12, 9, 0, 0, 0, mst)
    duration := time.Until(timestamp)

    // Extract weeks, days, hours, minutes, and seconds from the duration
    weeks := int(duration.Hours() / 24 / 7)
    days := int(duration.Hours()/24) % 7
    hours := int(duration.Hours()) % 24
    minutes := int(duration.Minutes()) % 60
    seconds := int(duration.Seconds()) % 60

    countdown := fmt.Sprintf(
        "Time left until Kubecon NA 2024: %d weeks, %d days, %d hours, %d minutes, %d seconds ⏰",
        weeks, days, hours, minutes, seconds,
    )

    // Write the countdown to the response
    fmt.Fprintln(w, countdown)
}

func main() {
    http.HandleFunc("/", countdownHandler)
    fmt.Println("Server listening on port 8080...")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Printf("Error starting server: %v\n", err)
    }
}
