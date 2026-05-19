package ufs.pipeline.test.app.backend;

public class HealthData {
    private String message;
    private String status;

    // Default Constructor
    public HealthData() {
    }

    // Explicit Getters and Setters
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
