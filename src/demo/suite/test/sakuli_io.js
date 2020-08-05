(async () => {
  const testCase = new TestCase("sakuli.io", 60, 70);

  try {
    await _navigateTo("https://sakuli.io/docs");
    await testCase.endOfStep("Open Sakuli Docs", 8, 10);
    await _click(_link(/Getting Started/));
    await testCase.endOfStep("Navigate to Getting Started", 3, 5);
    await _highlight(_code("npm init"));
    await testCase.endOfStep("Sakuli Landing Page", 10);
  } catch (e) {
    await testCase.handleException(e);
  } finally {
    testCase.saveResult();
  }
})();
