package ufs.pipeline.test.app.backend;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {
    @RequestMapping("/health/check")
    public @ResponseBody HealthData check() {
        HealthData data = new HealthData();
        data.setMessage("Hello");
        data.setStatus("FAILURE");

        return data;
    }
}
