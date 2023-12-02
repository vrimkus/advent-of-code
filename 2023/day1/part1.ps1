function Solution {
    $data = Get-Content -Path 'input.txt'
    return CalculateCalibrationSum $data
}

try {
    Push-Location $PSScriptRoot
    . './utils.ps1'
    Solution
} finally {
    Pop-Location
}
