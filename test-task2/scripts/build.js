const fs = require('fs');
const path = require('path');

const env = process.argv[2] || 'dev';
const outputDir = path.join(__dirname, `../dist/${env}`);

fs.mkdirSync(outputDir, { recursive: true });

fs.writeFileSync(
  path.join(outputDir, 'index.html'),
  '<!DOCTYPE html><html><head><title>My App</title></head><body><h1>Hello, World!</h1></body></html>'
);

console.log(`Build complete. Files are located in ${outputDir}`);
