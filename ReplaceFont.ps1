# Replace font of iTunes for Windows for Japanese
#
if ($args.length -eq 1) {
    $fontname = $args[0]
    
    # Check available font
    [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
    $families = (New-Object System.Drawing.Text.InstalledFontCollection).Families
    $isFont = $families -contains "$fontname"
    
    echo "$fontname is $isFont"
    
    if ($isFont -eq "True") {
        # path for iTunes plist file
        # $origFile = "C:\Program Files\iTunes\iTunes.Resources\ja.lproj\TextStyles.plist"
        $origFile = "C:\Program Files\iTunes\iTunes.Resources\en.lproj\TextStyles.plist"
        $newFile = "C:\temp\TextStyles.plist"
        
        # Change font name
        $repdata = (cat -Path $origFile -ReadCount 0) -join "`r`n" -creplace "(<key>font</key>`r`n`t`t<string>).*?(</string>)", "`$1$fontname`$2" | Out-File $newFile -Encoding UTF8
        
        echo "Save to $newFile."
        
        # Open folder
        ii C:\temp
    } else {
        echo "Available font as arg[0] not found."
    }
} else {
    echo "No argument."
    echo "Usage:"
    echo "    ReplaceFont.ps1 font-name"
    echo "ex)"
    echo "    ReplaceFont.ps1 `"Meiryo UI`" or ReplaceFont.ps1 Meiryo"
}

#
# test code
#

# creplace
# $repdata=Get-Content "C:\Program Files\iTunes\iTunes.Resources\ja.lproj\TextStyles.plist" | foreach { $_ -creplace ">Segoe.*?<", ">MeiryoKe_PGothic<" }
# $repdata | Out-File C:\temp\TextStyles.plist -Encoding UTF8

# delete null line
# $repdata = cat "C:\Program Files\iTunes\iTunes.Resources\ja.lproj\TextStyles.plist" |
#     % {
#         $_ -creplace "`t`t<key>font</key>", ""
#     } | ? {$_ -notmatch "^$|^Power Shell$|^-+$"}
