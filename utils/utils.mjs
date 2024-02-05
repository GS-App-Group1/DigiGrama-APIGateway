import puppeteer from 'puppeteer';
import fs from "fs"

const exportHTMLtoPDF = async (dataObj, outputFilename, response) => {
  // Read HTML template
  var htmlContent = `<!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        font-size: 18px; /* Base font size */
      }
  
      .text-huge {
        font-size: 2em; /* Double the size of the base font size */
      }
  
      .table {
        width: calc(100% - 40px); /* Adjust width to account for margin */
        margin: 20px; /* This adds a margin around the table */
        display: block;
      }
  
      table {
        width: 100%;
        border-collapse: collapse; /* Ensures that the border is collapsed into a single border */
      }
  
      td, th {
        padding: 20px; /* Increased padding to increase row height */
        font-size: 1em; /* Same as base font size */
        border: 1px solid black; /* Add border to table cells */
        height: 50px; /* Fixed height for each table cell */
      }
  
      table {
        border: 1px solid black; /* Add border around the table */
      }
  
      strong {
        font-size: 1.2em; /* 20% larger than the body font size */
      }
    </style>
  </head>
  <body>
      <p style="text-align:center;"><span class="text-huge"><strong>Grama Sevaka Certificate</strong></span></p>
      <div class="table">
          <table>
              <tbody>
                  <tr>
                      <td><strong>NIC</strong></td>
                      <td>nic</td>
                  </tr>
                  <tr>
                      <td><strong>Email</strong></td>
                      <td>email</td>
                  </tr>
                  <tr>
                      <td><strong>Address</strong></td>
                      <td>address</td>
                  </tr>
                  <tr>
                      <td><strong>Civil Status</strong></td>
                      <td>civilStatus</td>
                  </tr>
                  <tr>
                      <td><strong>Present Occupation</strong></td>
                      <td>presentOccupation</td>
                  </tr>
                  <tr>
                      <td><strong>Reason</strong></td>
                      <td>reason</td>
                  </tr>
                  <tr>
                      <td><strong>Division</strong></td>
                      <td>gsDivision</td>
                  </tr>
                  <tr>
                      <td><strong>Date</strong></td>
                      <td>date</td>
                  </tr>
              </tbody>
          </table>
      </div>
  </body>
  </html>`

  htmlContent = htmlContent.replace(
    /\b(?:nic|email|address|civilStatus|presentOccupation|reason|gsDivision|date)\b/g,
    (matched) => dataObj[matched]
  )
  
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  // Set the HTML content and generate PDF
  await page.setContent(htmlContent);
  await page.pdf({ path: outputFilename, format: 'A4' });
  
  // Close the browser
  await browser.close();

  
  // Stream the PDF file to the response
  const pdfStream = fs.createReadStream(outputFilename);
  pdfStream.pipe(response);
  
}
export default exportHTMLtoPDF

