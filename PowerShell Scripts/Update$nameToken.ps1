$dialog= Read-Variable -Parameters `
@{ Name = "media"; Title = "Path"; Root="/sitecore/"; Editor="item";Tab="General";},
@{ Name = "contentType"; Title = "Content Type"; Root="/sitecore/templates"; Editor="item";Tab="General";} `
-Description "This script will edit field value " `
-Title "Field Value Update" -Width 500 -Height 500 `
-OkButtonName "Proceed" -CancelButtonName "Abort"
 
if ($dialog -ne "ok")
{   
   Exit
}
 
cd $media.Paths.FullPath;
$templateId = $contentType.ID;
 
Write-Host "Process Starting";
 
Get-ChildItem -Recurse -Language * . |  ForEach-Object {
    $this = $_
 
    if($_.TemplateID -eq $templateId){     
        if($_.Fields["Your Field Name"].Value -eq '$name')
        {
                 $_.Editing.BeginEdit();
                 $_['Title']=$_.Name;
                 $_.Editing.EndEdit();
        }
    }    
}
 
Write-Host "Process Completed";