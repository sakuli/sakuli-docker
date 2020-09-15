(async () => {
    const testCase = new TestCase("Assimilation");
    const url = "https://sakuli.io/e2e-pages/fryed-egg";
    try {
        await _navigateTo(url);
        await _highlight(_heading1(/RESISTENCE IS FUTILE/), 2000);
    } catch (e) {
        await testCase.handleException(e);
    } finally {
        await testCase.saveResult();
    }
})();
