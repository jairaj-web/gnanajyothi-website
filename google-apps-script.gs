// Google Apps Script for Gnanajyothi School Contact Form
// This script receives form submissions and sends emails via Gmail

function doPost(e) {
  // Set CORS headers
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json'
  };
  
  try {
    // Parse the request body
    const data = JSON.parse(e.postData.contents);
    
    // Extract form data
    const firstName = data.firstName || '';
    const lastName = data.lastName || '';
    const email = data.email || '';
    const phone = data.phone || 'Not provided';
    const inquiry = data.inquiry || '';
    const message = data.message || '';
    
    // Format inquiry type
    const inquiryTypes = {
      'admission': 'Admission Inquiry',
      'general': 'General Information',
      'visit': 'Campus Visit Request',
      'feedback': 'Feedback',
      'other': 'Other Inquiry'
    };
    const inquiryLabel = inquiryTypes[inquiry] || inquiry;
    
    // Create email subject
    const subject = `Gnanajyothi School - ${inquiryLabel} from ${firstName} ${lastName}`;
    
    // Create email body
    const body = `
Dear Gnanajyothi School Team,

You have received a new contact form submission:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONTACT DETAILS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Name: ${firstName} ${lastName}
Email: ${email}
Phone: ${phone}
Inquiry Type: ${inquiryLabel}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MESSAGE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

${message}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This email was sent from the contact form on gnanajyothi.in
    `;
    
    // Send email using Gmail
    GmailApp.sendEmail(
      'sgjeschool@gmail.com',  // To address
      subject,                  // Subject
      body,                     // Plain text body
      {
        name: 'Gnanajyothi School Website',
        replyTo: email
      }
    );
    
    // Return success response
    return ContentService.createTextOutput(JSON.stringify({
      status: 'success',
      message: 'Email sent successfully'
    })).setResponseHeaders(headers);
    
  } catch (error) {
    // Log error for debugging
    console.error('Error in doPost:', error);
    
    // Return error response
    return ContentService.createTextOutput(JSON.stringify({
      status: 'error',
      message: error.toString()
    })).setResponseHeaders(headers);
  }
}

// Handle OPTIONS request for CORS preflight
function doOptions(e) {
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Content-Type': 'application/json'
  };
  
  return ContentService.createTextOutput('').setResponseHeaders(headers);
}
