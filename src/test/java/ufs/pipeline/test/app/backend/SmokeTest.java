package ufs.pipeline.test.app.backend;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class SmokeTest {
    @Autowired
	private AppController controller;

	@Test
	void contextLoads() throws Exception {
		assertThat(controller).isNotNull();
	}

    @Test
    void healthCheck() throws Exception {
        HealthData data = controller.check();

        assertThat(data.getMessage().contains("Hello"));
        assertThat(data.getStatus().contains("FAILURE"));
    }
}
