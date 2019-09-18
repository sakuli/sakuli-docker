const fs = require("fs-extra");

const [proc, src, target, ...rest] = process.argv;

if (target) {
  fs.remove(target)
    .then(() => {
      console.log(`Removed ${target}`);
    })
    .catch(err => {
      console.error(err);
      process.exit(-1);
    });
} else {
  console.error(`One of 'from' or 'to' path is missing.`);
  process.exit(-1);
}
