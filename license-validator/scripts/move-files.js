const fs = require('fs-extra');

const [proc, src, from, to, ...rest] = process.argv;

if (from && to) {
    fs.copy(from, to, {
        overwrite: true
    })
        .then(() => {
            console.log(`Successfully copied files from '${from}' to '${to}'.`)
            process.exit(0);
        })
        .catch(err => {
            console.error(err);
            process.exit(-1);
        });
} else {
    console.error(`One of 'from' or 'to' path is missing.`);
    process.exit(-1);
}
