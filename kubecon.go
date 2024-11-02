import (
	"fmt"
	"time"
)

func main() {
	cst := time.FixedZone("CST", -6*60*60)
	timestamp := time.Date(2024, time.November, 12, 10, 0, 0, 0, cst)
	// Calculate the duration until Kubecon kickoff
	duration := time.Until(timestamp)

	// Extract weeks, days, hours, minutes, and seconds from the duration
	weeks := int(duration.Hours() / 24 / 7)
	days := int(duration.Hours() / 24) % 7
	hours := int(duration.Hours()) % 24
	minutes := int(duration.Minutes()) % 60
	seconds := int(duration.Seconds()) % 60

	fmt.Printf("Time left until Kubecon NA 2024: %d weeks, %d days, %d hours, %d minutes, %d seconds ⏰ \n", weeks, days, hours, minutes, seconds)
}
