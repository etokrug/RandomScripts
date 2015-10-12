<#
    !!!!! READ FIRST !!!!!
    In order for this to work you have to bring in a library called PDFSharp.
    You must compile this C# library into a DLL that PowerShell can access.
    If you do not do that this script is meaningless.
    
    PDFsharp Project Home:
    http://www.pdfsharp.net/?AspxAutoDetectCookieSupport=1
    
    Download:
    http://sourceforge.net/projects/pdfsharp/files/pdfsharp/PDFsharp%201.32/
    
    WARNING: I can't vouch for the version that's up there, there may be compatibility
    issues with later versions of their project.

#>
<#--------------------------------------------------------------------------------#>
# Set this equal to the path where you have PDFs you want to combine
# Example: C:\Users\[username]\Documents\PDFSharpFolder
$folderPath = "" 

# Set this equal to the path where you PDFSharp dll is located
# Example: C:\Users\[username]\Documents\PDFSharpDllFolder\PdfSharp.dll
$dllPath = "" 

# Set this equal to the filename you want the concatenated files to be
# Example: C:\Users\[username]\Documents\PDFSharpFolder\CombinedPDF.pdf
$combinedPDF = ""

Set-Location $folderPath

# Adds the PDFSharp DLL to be used in PowerShell

Add-Type -Path $dllPath

<# Main function takes a path (path) and a filename (string) #>          
Function Merge-PDF {            
    Param($path, $filename)                        
    # Creates the new PDF object to be used for output
    $output = New-Object PdfSharp.Pdf.PdfDocument     
    # Create a PDF reader object to access PDF objects in the path       
    $PdfReader = [PdfSharp.Pdf.IO.PdfReader]
    # Object to define how to open/read existing PDF documents
    $PdfDocumentOpenMode = [PdfSharp.Pdf.IO.PdfDocumentOpenMode]                        
    
    # Loop which follows path (non recursively) into the folder where PDFs exist to be concatenated
    foreach($i in (gci $path *.pdf)) {

        Write-Output $i.FullName
        $input = New-Object PdfSharp.Pdf.PdfDocument            
        $input = $PdfReader::Open($i.fullname, $PdfDocumentOpenMode::Import)            
        $input.Pages | %{$output.AddPage($_)}            
    }                        
    # Saves all output into separate PDF file using string $filename 
    $output.Save($filename)            
}

<# calls the actual function #>

Merge-PDF $folderPath $combinedPDF