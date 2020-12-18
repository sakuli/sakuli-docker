(async () => {
  const testCase = new TestCase("OCR");
  const url = "https://sakuli.io/e2e-pages/sandbox/#";
  try {
    await testCase.startStep("Navigate to website");
    await _navigateTo(url);
    await _wait(2000);

    await testCase.startStep("find 'element in one place'");
    await _getRegionByText("element in one place").highlight(1);
  } catch (e) {
    await testCase.handleException(e);
  } finally {
    await testCase.saveResult();
  }
})();
