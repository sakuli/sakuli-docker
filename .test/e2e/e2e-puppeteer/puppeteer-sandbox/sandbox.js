(async () => {
  const tc = new TestCase('sandbox', 100, 200);
  const puppeteer = require('puppeteer');
  const env = new Environment();

  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: {width: 1000, height: 1000}
  });

  try {
    const page = await browser.newPage();
    await page.goto('https://sakuli.io/e2e-pages/sandbox/');

    const frames = page.frames()[0].childFrames();
    //click license information
    await frames[0].click('body > nav > a');
    //click go back to fried egg
    await frames[0].click('body > nav > a');
    await env.sleep(1)
  } catch (e) {
    await tc.handleException(e);
  } finally {
    await tc.saveResult();
    await browser.close();
  }
})();