
function CalculateCalibrationSum {
    param (
        [Parameter(Mandatory)]
        [string[]] $CalibrationDocument,

        [Parameter()]
        [switch] $IncludeSpelled
    )

    $sum = 0
    foreach ($text in $CalibrationDocument) {
        $value = GetNewCalibrationValue $text -IncludeSpelled:$IncludeSpelled
        $sum += $value
    }

    return $sum
}

function GetNewCalibrationValue {
    param (
        [Parameter(Mandatory)]
        [string] $Text,

        [Parameter()]
        [switch] $IncludeSpelled
    )

    $numbers = if ($IncludeSpelled) {
        ResolveSpelledCalibrationValues $Text
    } else {
        $Text.ToCharArray() | Where-Object { $_ -match '\d' }
    }

    return [int](-join @($numbers[0], $numbers[-1]))
}

function ResolveSpelledCalibrationValues {
    param (
        [Parameter(Mandatory)]
        [string] $Text
    )

    $spelledValues = [ordered]@{
        sixteen  = 16
        fourteen = 14
        one      = 1
        two      = 2
        three    = 3
        four     = 4
        five     = 5
        six      = 6
        seven    = 7
        eight    = 8
        nine     = 9
        ten      = 10
        eleven   = 11
        twelve   = 12
        thirteen = 13
        fifteen  = 15
    }

    $patterns = @($spelledValues.Keys) + @('\d')

    $allMatches = $Text | Select-String -Pattern ($patterns -join '|') -AllMatches  | ForEach-Object { $_.Matches }

    $resolvedValues = @()
    foreach ($match in $allMatches) {
        $numeric = $null
        if ([int]::TryParse($match.Value, [ref]$numeric)) {
            $resolvedValues += $numeric
        } else {
            $resolvedValues += $spelledValues[$match.Value]
        }
    }

    return -join $resolvedValues
}