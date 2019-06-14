(async () => {
  const testCase = new TestCase("calculator", 60, 70);
  testCase.addImagePaths("./assets");
  const env = new Environment();
  const screen = new Region();
  const appCalc = new Application("gnome-calculator");

  try {
    await appCalc.open();
    await screen.waitForImage("calculator.png", 10);

    await env.type("525");
    await env.sleep(2);
    await screen.find("plus.png").then(target => target.click());
    const one = await screen.find("one.png");
    await one.click();
    const zero = await screen.find("zero.png");
    await zero.click();
    await zero.click();
    await env.type(Key.ENTER);
    await screen.waitForImage("result.png", 5);
    await testCase.endOfStep("Calculation", 30);
  } catch (e) {
    await testCase.handleException(e);
  } finally {
    await appCalc.close(true); //silent
    testCase.saveResult();
  }
})().then(done);
