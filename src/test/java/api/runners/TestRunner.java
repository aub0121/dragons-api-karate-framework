package api.runners;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	@Karate.Test
	public Karate runTests() {
		return Karate.run("classpath:features")
				.tags("Regression");
	}
}
