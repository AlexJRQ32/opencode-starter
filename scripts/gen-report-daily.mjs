import fs from 'fs';
import path from 'path';
import { ZipArchive } from 'archiver';

const vaultDir = "C:\\Users\\roble\\Documents\\Obsidian Vault\\opencode";
const outBase = "C:\\Users\\roble\\OneDrive\\Documentos\\Reportes OpenCode";

// Date helpers
function pad(n) { return String(n).padStart(2, '0') }
const d = new Date();
const yyyy = d.getFullYear();
const mm = pad(d.getMonth() + 1);
const dd = pad(d.getDate());
const dateStr = `${yyyy}-${mm}-${dd}`;
const months = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];
const monthName = months[d.getMonth()];
const dateLabel = `${dd} de ${monthName} de ${yyyy}`;

// Read markdown files from a folder
function readDir(dir) {
  const items = [];
  try {
    fs.readdirSync(dir).forEach(f => {
      const p = path.join(dir, f);
      if (fs.statSync(p).isFile() && f.endsWith('.md') && !f.startsWith('_')) {
        items.push({ name: f, content: fs.readFileSync(p, 'utf8') });
      }
    });
  } catch {}
  return items;
}

const sessions = readDir(path.join(vaultDir, "sessions"));
const decisions = readDir(path.join(vaultDir, "decisions"));
const learnings = readDir(path.join(vaultDir, "learnings"));
const activities = readDir(path.join(vaultDir, "activity"));

function esc(s) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

const FONT = 'Calibri';
const SZ = '22';
const LINE = '276';

function p(text, opts = {}) {
  let x = '<w:p><w:pPr><w:spacing w:line="' + LINE + '" w:lineRule="auto"/>';
  if (opts.bold || opts.h1 || opts.h2) x += '<w:pStyle w:val="' + (opts.h1 ? 'Heading1' : opts.h2 ? 'Heading2' : 'Title') + '"/>';
  if (opts.center && !opts.h1) x += '<w:jc w:val="center"/>';
  x += '</w:pPr>';
  const sz = opts.h1 ? '28' : opts.h2 ? '24' : SZ;
  x += '<w:r><w:rPr><w:rFonts w:ascii="' + FONT + '" w:hAnsi="' + FONT + '"/>';
  x += '<w:sz w:val="' + sz + '"/><w:szCs w:val="' + sz + '"/>';
  if (opts.bold || opts.h1 || opts.h2) x += '<w:b/><w:bCs/>';
  x += '</w:rPr><w:t xml:space="preserve">' + esc(text) + '</w:t></w:r></w:p>';
  return x;
}

function bullet(text) {
  let x = '<w:p><w:pPr><w:pStyle w:val="ListBullet"/><w:spacing w:line="' + LINE + '" w:lineRule="auto"/>';
  x += '<w:ind w:left="720"/></w:pPr>';
  x += '<w:r><w:rPr><w:rFonts w:ascii="' + FONT + '" w:hAnsi="' + FONT + '"/>';
  x += '<w:sz w:val="' + SZ + '"/><w:szCs w:val="' + SZ + '"/>';
  x += '</w:rPr><w:t xml:space="preserve">' + esc(text) + '</w:t></w:r></w:p>';
  return x;
}

let body = '';

body += p("Reporte de Actividad - " + dateLabel, { h1: true, bold: true, center: true });
body += p("Generado automáticamente por opencode", { center: true });
body += p("");

// Activity
if (activities.length) {
  body += p("Actividad del día", { h2: true, bold: true });
  for (const a of activities) {
    const entries = a.content.split(/### /).slice(1);
    for (const entry of entries.slice(0, 10).reverse()) {
      const lines = entry.split('\n').filter(l => l.trim());
      if (!lines.length) continue;
      const title = lines[0].replace(/[*#]/g, '').trim();
      if (title) body += bullet(title);
    }
  }
}

// Sessions
body += p("Sesiones", { h2: true, bold: true });
for (const s of sessions) {
  const entries = s.content.split(/## /).slice(1);
  for (const entry of entries.slice(0, 3)) {
    const lines = entry.split('\n').filter(l => l.trim());
    if (!lines.length) continue;
    const title = lines[0].replace(/[*#]/g, '').trim();
    if (title) body += p(title, { bold: true });
    const bullets = entry.split('\n').filter(l => l.trim().startsWith('- '));
    for (const b of bullets.slice(0, 5)) {
      let txt = b.replace(/^-\s*/, '').replace(/`([^`]+)`/g, '$1').replace(/\*\*([^*]+)\*\*/g, '$1');
      if (txt.trim() && !txt.includes('Relacionado') && !txt.includes('Tags:')) body += bullet(txt);
    }
  }
}

// Decisions
body += p("Decisiones", { h2: true, bold: true });
for (const d of decisions) {
  const entries = d.content.split(/## /).slice(1);
  for (const entry of entries.slice(0, 3)) {
    const lines = entry.split('\n').filter(l => l.trim());
    if (!lines.length) continue;
    const title = lines[0].replace(/[*#]/g, '').trim();
    if (title) body += p(title, { bold: true });
    for (const l of lines.slice(1)) {
      let txt = l.replace(/^-\s*\*\*Contexto:\*\*\s*/, '').replace(/^-\s*\*\*Opci.n:\*\*\s*/, '')
                 .replace(/^-\s*/, '').replace(/`([^`]+)`/g, '$1').replace(/\*\*/g, '');
      if (txt.trim() && !txt.includes('Relacionado') && !txt.includes('Tags:')) body += bullet(txt);
    }
  }
}

// Learnings
body += p("Aprendizajes", { h2: true, bold: true });
for (const lr of learnings) {
  const entries = lr.content.split(/## /).slice(1);
  for (const entry of entries) {
    const lines = entry.split('\n').filter(l => l.trim());
    if (!lines.length) continue;
    const title = lines[0].replace(/[*#]/g, '').trim();
    if (title) body += p(title, { bold: true });
    for (const l of lines.slice(1)) {
      let txt = l.replace(/^-\s*/, '').replace(/`([^`]+)`/g, '$1');
      if (txt.trim() && !txt.includes('Relacionado') && !txt.includes('Tags:')) body += bullet(txt);
    }
  }
}

// XML parts
const docXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
  xmlns:mo="http://schemas.microsoft.com/office/mac/office/2008/main"
  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
  xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
  mc:Ignorable="w14 w15 wpc mo">
  <w:body>${body}
    <w:sectPr>
      <w:pgSz w:w="11906" w:h="16838"/>
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"/>
      <w:docGrid w:linePitch="360"/>
    </w:sectPr>
  </w:body>
</w:document>`;

const stylesXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:style w:type="paragraph" w:styleId="Normal" w:default="1">
    <w:name w:val="Normal"/>
    <w:rPr><w:rFonts w:ascii="${FONT}" w:hAnsi="${FONT}"/><w:sz w:val="${SZ}"/><w:szCs w:val="${SZ}"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading1">
    <w:name w:val="heading 1"/>
    <w:pPr><w:spacing w:before="240" w:after="120" w:line="${LINE}" w:lineRule="auto"/><w:jc w:val="center"/></w:pPr>
    <w:rPr><w:b/><w:bCs/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Heading2">
    <w:name w:val="heading 2"/>
    <w:pPr><w:spacing w:before="200" w:after="80" w:line="${LINE}" w:lineRule="auto"/></w:pPr>
    <w:rPr><w:b/><w:bCs/><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="Title">
    <w:name w:val="Title"/>
    <w:rPr><w:b/><w:bCs/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr>
  </w:style>
  <w:style w:type="paragraph" w:styleId="ListBullet">
    <w:name w:val="List Bullet"/>
    <w:pPr><w:spacing w:line="${LINE}" w:lineRule="auto"/><w:ind w:left="720" w:hanging="360"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr></w:pPr>
    <w:rPr><w:rFonts w:ascii="${FONT}" w:hAnsi="${FONT}"/><w:sz w:val="${SZ}"/><w:szCs w:val="${SZ}"/></w:rPr>
  </w:style>
</w:styles>`;

const numberingXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:abstractNum w:abstractNumId="0">
    <w:multiLevelType w:val="hybridMultilevel"/>
    <w:lvl w:ilvl="0">
      <w:start w:val="1"/>
      <w:numFmt w:val="bullet"/>
      <w:lvlText w:val="&#x2022;"/>
      <w:lvlJc w:val="left"/>
      <w:pPr><w:ind w:left="720" w:hanging="360"/></w:pPr>
      <w:rPr><w:rFonts w:ascii="${FONT}" w:hAnsi="${FONT}" w:cs="${FONT}"/><w:sz w:val="${SZ}"/></w:rPr>
    </w:lvl>
  </w:abstractNum>
  <w:num w:numId="1"><w:abstractNumId w:val="0"/></w:num>
</w:numbering>`;

const contentTypesXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
  <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
  <Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>
  <Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>
  <Override PartName="/word/webSettings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.webSettings+xml"/>
</Types>`;

const relsXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>`;

const settingsXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:settings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
  xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
  mc:Ignorable="w14 w15">
  <w:defaultTabStop w:val="720"/>
</w:settings>`;

const webSettingsXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:webSettings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
  xmlns:w15="http://schemas.microsoft.com/office/word/2012/wordml"
  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
  mc:Ignorable="w14 w15">
  <w:optimizeForBrowser/>
</w:webSettings>`;

const docRelsXml = `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>
  <Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings" Target="webSettings.xml"/>
</Relationships>`;

const yearDir = `Año - ${yyyy}`;
const monthDir = `Mes - ${monthName}`;
const fullDir = path.join(outBase, yearDir, monthDir);
fs.mkdirSync(fullDir, { recursive: true });
const outPath = path.join(fullDir, `reporte-${dateStr}.docx`);

const output = fs.createWriteStream(outPath);
const archive = new ZipArchive({ zlib: { level: 9 } });

archive.pipe(output);
archive.append(contentTypesXml, { name: '[Content_Types].xml' });
archive.append(relsXml, { name: '_rels/.rels' });
archive.append(docXml, { name: 'word/document.xml' });
archive.append(docRelsXml, { name: 'word/_rels/document.xml.rels' });
archive.append(stylesXml, { name: 'word/styles.xml' });
archive.append(numberingXml, { name: 'word/numbering.xml' });
archive.append(settingsXml, { name: 'word/settings.xml' });
archive.append(webSettingsXml, { name: 'word/webSettings.xml' });

await archive.finalize();
console.log("OK: " + outPath);
