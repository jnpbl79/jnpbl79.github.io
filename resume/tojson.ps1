# function ConvertTo-CamelCase {
#     param (
#         [Parameter(Mandatory = $true)]
#         [object]$InputObject
#     )

#     $outputObject = [PSCustomObject]@{ }

#     if ($InputObject -is [System.Collections.IDictionary]) {

#         foreach ($key in $InputObject.Keys) {
#             $propertyName = $key.Substring(0, 1).ToLower() + $key.Substring(1)
#             $outputObject | Add-Member -MemberType NoteProperty -Name $propertyName -Value $InputObject.$key
#         }
#     }
#     else {
#         $InputObject.PSObject.Properties | ForEach-Object {
#             $propertyName = $_.Name.Substring(0, 1).ToLower() + $_.Name.Substring(1)
#             $outputObject | Add-Member -MemberType NoteProperty -Name $propertyName -Value $_.Value
#         }
#     }
#     return $outputObject
# }

. .\resume-data.ps1

# $resume.Work | ForEach-Object {
#     $startDate = Get-Date $_.DateStart
#     $endDate = if ($_.DateEnd) { Get-Date $_.DateEnd }
#     $formattedDateStart = $startDate.ToString("MMM yyyy")
#     $formattedDateEnd = if ($endDate) { $endDate.ToString("MMM yyyy") } else { "Present" }
#     $_ | Add-Member -MemberType NoteProperty -Name "ParsedDateStart" -Value $startDate
#     $_ | Add-Member -MemberType NoteProperty -Name "ParsedDateEnd" -Value $endDate
#     $_ | Add-Member -MemberType NoteProperty -Name "FormattedDateStart" -Value $formattedDateStart
#     $_ | Add-Member -MemberType NoteProperty -Name "FormattedDateEnd" -Value $formattedDateEnd
# } #| Sort-Object -Property { $_.DateEnd -eq $null }, ParsedDateEnd, ParsedDateStart -Descending

$jsonOptions = [System.Text.Json.JsonSerializerOptions]@{
    PropertyNamingPolicy = [System.Text.Json.JsonNamingPolicy]::CamelCase
    WriteIndented = $true
}

$json = [System.Text.Json.JsonSerializer]::Serialize($resume, $jsonOptions)
$json | Set-Content -Path '.\resume.json' -Force -Encoding UTF8


# $resume = ConvertTo-CamelCase -InputObject $resume
# $resume.basics = ConvertTo-CamelCase -InputObject $resume.basics
# $resume.basics.location = ConvertTo-CamelCase -InputObject $resume.basics.location
# $resume.basics.profiles = $resume.basics.profiles | ForEach-Object { ConvertTo-CamelCase -InputObject $_ }
# $resume.work = $resume.work | ForEach-Object { ConvertTo-CamelCase -InputObject $_ }
# $resume.certifications = $resume.certifications | ForEach-Object { ConvertTo-CamelCase -InputObject $_ }
# $resume.languages = $resume.languages | ForEach-Object { ConvertTo-CamelCase -InputObject $_ }
# $resume.interests = $resume.interests | ForEach-Object { ConvertTo-CamelCase -InputObject $_ }
# $resume.metatags = ConvertTo-CamelCase -InputObject $resume.metatags


# $resumeJson = ConvertTo-Json -InputObject $resume -Depth 10

# # Write the JSON string to a file
# $resumeJson | Set-Content -Path '.\resume.json' -Force -Encoding UTF8