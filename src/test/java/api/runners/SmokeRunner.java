package api.runners;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {
	
	@Karate.Test
	public Karate runTests() {
		return Karate.run("classpath:features")
				.tags("Smoke");
	}

}
