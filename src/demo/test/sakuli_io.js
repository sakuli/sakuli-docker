(async () => {
  const testCase = new TestCase("sakuli.io", 60, 70);

  try {
    await _navigateTo("https://sakuli.io");
    await testCase.endOfStep("Open Landing Page", 8, 10);
    await _click(_link("Getting started"));
    await testCase.endOfStep("Navigate to Getting Started", 3, 5);
    await _highlight(_code("npm init"));
    await testCase.endOfStep("Sakuli Landing Page", 10);
  } catch (e) {
    await testCase.handleException(e);
  } finally {
    testCase.saveResult();
  }
})().then(done);
