Feature: Importing coverage data

  As a SonarQube user
  I want to import my coverage metric values into SonarQube
  In order to be able to use relevant SonarQube features


  Scenario: Importing coverage reports
      GIVEN the project "coverage_project"

      WHEN I run sonar-scanner with following options:
          """
          -Dsonar.cxx.coverage.reportPath=ut-coverage.xml
          -Dsonar.cxx.coverage.itReportPath=it-coverage.xml
          -Dsonar.cxx.coverage.overallReportPath=overall-coverage.xml
          -Dsonar.cxx.coverage.forceZeroCoverage=False
          """

      THEN the analysis finishes successfully
          AND the analysis in server has completed
          AND the analysis log contains no error/warning messages except those matching:
              """
              .*WARN.*Unable to get a valid mac address, will use a dummy address
              .*WARN.*cannot find the sources for '#include <iostream>'
              """
          AND the following metrics have following values:
              | metric                  | value |
              | coverage                | 20.0  |
              | line_coverage           | 12.5  |
              | branch_coverage         | 50    |
              | it_coverage             | 34.5  |
              | it_line_coverage        | 26.3  |
              | it_branch_coverage      | 50    |
              | overall_coverage        | 28.6  |
              | overall_line_coverage   | 20.0  |
              | overall_branch_coverage | 50.0  |


#  Scenario: Importing coverage reports zeroing coverage for untouched files
#      GIVEN the project "coverage_project"

#      WHEN I run sonar-scanner with following options:
#          """
#          -Dsonar.cxx.coverage.reportPath=ut-coverage.xml
#          -Dsonar.cxx.coverage.itReportPath=it-coverage.xml
#          -Dsonar.cxx.coverage.overallReportPath=overall-coverage.xml
#          -Dsonar.cxx.coverage.forceZeroCoverage=True
#          """

#      THEN the analysis finishes successfully
#          AND the analysis in server has completed      
#          AND the analysis log contains no error/warning messages except those matching:
#              """
#              .*WARN.*Unable to get a valid mac address, will use a dummy address
#              .*WARN.*cannot find the sources for '#include <iostream>'
#              """
#          AND the following metrics have following values:
#              | metric                  | value |
#              | coverage                | 8.5   |
#              | line_coverage           | 5.5   |
#              | branch_coverage         | 50    |
#              | it_coverage             | 20.3  |
#              | it_line_coverage        | 14.8  |
#              | it_branch_coverage      | 50    |
#              | overall_coverage        | 28.1  |
#              | overall_line_coverage   | 22    |
#              | overall_branch_coverage | 50    |


#  Scenario: Zeroing coverage measures without importing reports

#      If we don't pass coverage reports *and* request zeroing untouched
#      files at the same time, all coverage measures, except the branch
#      ones, should be 'zero'. The branch coverage measures remain 'None',
#      since its currently ignored by the 'force zero...'
#      implementation

#      GIVEN the project "coverage_project"

#      WHEN I run sonar-scanner with following options:
#          """
#          -Dsonar.cxx.coverage.reportPath=dummy.xml
#          -Dsonar.cxx.coverage.itReportPath=dummy.xml
#          -Dsonar.cxx.coverage.overallReportPath=dummy.xml
#          -Dsonar.cxx.coverage.forceZeroCoverage=True
#          """

#      THEN the analysis finishes successfully
#          AND the analysis in server has completed
#          AND the analysis log contains no error/warning messages except those matching:
#              """
#              .*WARN.*Unable to get a valid mac address, will use a dummy address
#              .*WARN.*cannot find the sources for '#include <iostream>'
#              .*WARN.*Cannot find a report for '.*'
#              """
#          AND the following metrics have following values:
#              | metric                  | value |
#              | coverage                | 0     |
#              | line_coverage           | 0     |
#              | branch_coverage         | None  |
#              | it_coverage             | 0     |
#              | it_line_coverage        | 0     |
#              | it_branch_coverage      | None  |
#              | overall_coverage        | 0     |
#              | overall_line_coverage   | 0     |
#              | overall_branch_coverage | None  |
