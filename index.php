<?php
// Serve static HTML homepage - completely bypass WordPress
if (file_exists(__DIR__ . '/index.html')) {
    // Read and serve index.html directly
    header('Content-Type: text/html; charset=UTF-8');
    header('Cache-Control: public, max-age=604800');
    readfile(__DIR__ . '/index.html');
    exit;
}
// Fallback - should never reach here
echo 'Homepage not found';
exit;
?>
