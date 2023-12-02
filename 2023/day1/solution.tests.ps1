BeforeAll {
    . (Join-Path -Path $PSScriptRoot -ChildPath 'utils.ps1')
}


Describe "CanResolveNewCalibrationValues" {
    It "Returns <expected> (<text>)" -ForEach @(
        @{
            Text = '1abc2'; Expected = 12
        }
        @{
            Text = 'pqr3stu8vwx'; Expected = 38
        }
        @{
            Text = 'a1b2c3d4e5f'; Expected = 15
        }
        @{
            Text = 'treb7uchet'; Expected = 77
        }
    ) {
        GetNewCalibrationValue $Text -IncludeSpelled | Should -Be $Expected
    }
}

Describe "CanResolveSpelledCalibrationValues" {
    It "Returns <expected> (<text>)" -ForEach @(
        @{
            Text = 'two1nine'; Expected = 29
        }
        @{
            Text = 'eightwothree'; Expected = 83
        }
        @{
            Text = 'abcone2threexyz'; Expected = 13
        }
        @{
            Text = 'xtwone3four'; Expected = 24
        }
        @{
            Text = '4nineeightseven2'; Expected = 42
        }
        @{
            Text = 'zoneight234'; Expected = 14
        }
        @{
            Text = '7pqrstsixteen'; Expected = 76
        }
    ) {
        GetNewCalibrationValue $Text -IncludeSpelled | Should -Be $Expected
    }
}