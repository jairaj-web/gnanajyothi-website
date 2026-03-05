<?php
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Pragma: no-cache");
header("Access-Control-Allow-Origin: https://gnanajyothi.in");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["status" => "error", "message" => "Invalid request"]);
    exit;
}

$input = json_decode(file_get_contents("php://input"), true);
if (!$input) { $input = $_POST; }

$parentName  = htmlspecialchars(trim($input["parentName"]  ?? "Not provided"));
$phone       = htmlspecialchars(trim($input["phone"]       ?? "Not provided"));
$emailFrom   = filter_var(trim($input["email"] ?? ""), FILTER_VALIDATE_EMAIL);
$studentName = htmlspecialchars(trim($input["studentName"] ?? "Not provided"));
$grade       = htmlspecialchars(trim($input["grade"]       ?? "Not provided"));
$message     = htmlspecialchars(trim($input["message"]     ?? "Not provided"));

if (!$parentName || !$phone || !$message) {
    echo json_encode(["status" => "error", "message" => "Required fields missing"]);
    exit;
}

$to      = "sgjeschool@gmail.com";
$subject = "New Enquiry - " . $parentName . " (" . $grade . ")";
$date    = date("d M Y, h:i A", time() + 19800);

$htmlBody = '<!DOCTYPE html><html><head><meta charset="UTF-8"></head><body style="margin:0;padding:20px;background:#f5f5f5;font-family:Arial,sans-serif">'
. '<div style="max-width:600px;margin:0 auto;border:1px solid #ddd;border-radius:10px;overflow:hidden;background:#fff">'
. '<div style="background:linear-gradient(135deg,#1B5E20,#4CAF50);padding:25px;text-align:center">'
. '<h2 style="color:#FFD700;margin:0;font-size:22px">New Website Enquiry</h2>'
. '<p style="color:rgba(255,255,255,.9);margin:6px 0 0;font-size:14px">Gnanajyothi School &mdash; gnanajyothi.in</p>'
. '</div>'
. '<div style="padding:25px">'
. '<table style="width:100%;border-collapse:collapse;font-size:15px">'
. '<tr style="background:#F0F9F1"><td style="padding:12px 15px;font-weight:bold;color:#1B5E20;width:40%;border-bottom:1px solid #e0e0e0">Parent Name</td><td style="padding:12px 15px;color:#333;border-bottom:1px solid #e0e0e0">' . $parentName . '</td></tr>'
. '<tr><td style="padding:12px 15px;font-weight:bold;color:#1B5E20;border-bottom:1px solid #e0e0e0">Phone</td><td style="padding:12px 15px;color:#333;border-bottom:1px solid #e0e0e0">' . $phone . '</td></tr>'
. '<tr style="background:#F0F9F1"><td style="padding:12px 15px;font-weight:bold;color:#1B5E20;border-bottom:1px solid #e0e0e0">Email</td><td style="padding:12px 15px;color:#333;border-bottom:1px solid #e0e0e0">' . $emailFrom . '</td></tr>'
. '<tr><td style="padding:12px 15px;font-weight:bold;color:#1B5E20;border-bottom:1px solid #e0e0e0">Student Name</td><td style="padding:12px 15px;color:#333;border-bottom:1px solid #e0e0e0">' . $studentName . '</td></tr>'
. '<tr style="background:#F0F9F1"><td style="padding:12px 15px;font-weight:bold;color:#1B5E20">Enquiry For</td><td style="padding:12px 15px;color:#333">' . $grade . '</td></tr>'
. '</table>'
. '<div style="margin-top:20px;background:#F0F9F1;border-left:4px solid #4CAF50;padding:15px 20px;border-radius:0 8px 8px 0">'
. '<p style="font-weight:bold;color:#1B5E20;margin:0 0 8px">Message:</p>'
. '<p style="color:#333;margin:0;line-height:1.7">' . $message . '</p>'
. '</div></div>'
. '<div style="background:#f5f5f5;padding:15px;text-align:center;border-top:1px solid #ddd">'
. '<p style="color:#888;font-size:12px;margin:0">Submitted: ' . $date . ' IST</p>'
. '<p style="color:#888;font-size:12px;margin:5px 0 0">Reply to this email to respond to the enquiry</p>'
. '</div></div></body></html>';

$headers  = "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=UTF-8\r\n";
$headers .= "From: Gnanajyothi Website <no-reply@gnanajyothi.in>\r\n";
$headers .= "Reply-To: " . $emailFrom . "\r\n";
$headers .= "X-Mailer: PHP/" . phpversion();

$sent = mail($to, $subject, $htmlBody, $headers);

if ($sent) {
    echo json_encode(["status" => "success"]);
} else {
    echo json_encode(["status" => "error", "message" => "Mail failed to send"]);
}
