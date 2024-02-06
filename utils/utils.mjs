import fs from "fs"
import PDFDocument from "pdfkit"

function createPdf(dataObj, outputPdfPath, currentDirName) {
    return new Promise((resolve, reject) => {
      const fields = [
        { label: 'NIC', value: 'nic' },
        { label: 'Email', value: 'email' },
        { label: 'Address', value: 'address' },
        { label: 'Civil Status', value: 'civilStatus' },
        { label: 'Present Occupation', value: 'presentOccupation' },
        { label: 'Reason', value: 'reason' },
        { label: 'Division', value: 'gsDivision' },
        { label: 'Date', value: 'date' }
      ];

      const doc = new PDFDocument({ margin: 50 });

      // Pipe the PDF to a file
      const stream = fs.createWriteStream(outputPdfPath);
      doc.pipe(stream);

      // Add content to the PDF
      doc.font('Helvetica-Bold').fontSize(24).text('Grama Sevaka Certificate', { align: 'center' }).moveDown();

      fields.forEach(field => {
          doc.font('Helvetica').fontSize(16).text(`${field.label}: ${dataObj[field.value]}`, {align: 'center'}).moveDown();
      });

      // Finalize the PDF
      doc.end();

      // Handle stream events
      stream.on('finish', () => {
          resolve(outputPdfPath);
      });

      stream.on('error', (err) => {
          reject(err);
      });
    });
}
  
export default createPdf

