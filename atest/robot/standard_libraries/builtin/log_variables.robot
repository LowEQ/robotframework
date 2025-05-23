*** Settings ***
Suite Setup       Run Tests    --variable cli_var_1:CLI1 --variable cli_var_2:CLI2 --variable cli_var_3:CLI3
...               standard_libraries/builtin/log_variables.robot
Resource          atest_resource.robot

*** Test Cases ***
Log Variables In Suite Setup
    Set Test Variable    ${KW}    ${SUITE.setup[7]}
    Set Test Variable    ${INDEX}    ${0}
    Check Variable Message    \${/} = *    pattern=yes
    Check Variable Message    \${:} = ${:}
    Check Variable Message    \${\\n} =
    Check Variable Message    \${cli_var_1} = CLI1
    Check Variable Message    \${cli_var_2} = CLI2
    Check Variable Message    \${cli_var_3} = CLI3
    Check Variable Message    \${DEBUG_FILE} = NONE
    Check Variable Message    \&{DICT} = { key=value | two=2 }
    Check Variable Message    \${ENDLESS} = repeat('RF')
    Check Variable Message    \${EXECDIR} = *    pattern=yes
    Check Variable Message    \${False} = *    pattern=yes
    Check Variable Message    \${ITERABLE} = <generator object <genexpr> at 0x*>    pattern=yes
    Check Variable Message    \@{LIST} = [ Hello | world ]
    Check Variable Message    \${LOG_FILE} = NONE
    Check Variable Message    \${LOG_LEVEL} = INFO
    Check Variable Message    \${None} = None
    Check Variable Message    \${null} = None
    Check Variable Message    \&{OPTIONS} = { rpa=False | include=[] | exclude=[] | skip=[] | skip_on_failure=[] | console_width=78 }
    Check Variable Message    \${OUTPUT_DIR} = *    pattern=yes
    Check Variable Message    \${OUTPUT_FILE} = *    pattern=yes
    Check Variable Message    \${PREV_TEST_MESSAGE} =
    Check Variable Message    \${PREV_TEST_NAME} =
    Check Variable Message    \${PREV_TEST_STATUS} =
    Check Variable Message    \${REPORT_FILE} = NONE
    Check Variable Message    \${SCALAR} = Hi tellus
    Check Variable Message    \${SPACE} =
    Check Variable Message    \${SUITE_DOCUMENTATION} =
    Check Variable Message    \&{SUITE_METADATA} = { }
    Check Variable Message    \${SUITE_NAME} = *    pattern=yes
    Check Variable Message    \${suite_setup_global_var} = Global var set in suite setup
    Check Variable Message    \@{suite_setup_global_var_list} = [ Global var set in | suite setup ]
    Check Variable Message    \${suite_setup_local_var} = Variable available only locally in suite setup
    Check Variable Message    \${suite_setup_suite_var} = Suite var set in suite setup
    Check Variable Message    \@{suite_setup_suite_var_list} = [ Suite var set in | suite setup ]
    Check Variable Message    \${SUITE_SOURCE} = *    pattern=yes
    Check Variable Message    \${TEMPDIR} = *    pattern=yes
    Check Variable Message    \${True} = *    pattern=yes
    Length Should Be    ${kw.messages}    37

Log Variables In Test
    ${test} =    Check Test Case    Log Variables
    Set Test Variable    ${KW}    ${test[0]}
    Set Test Variable    ${INDEX}    ${1}
    Check Variable Message    \${/} = *    pattern=yes
    Check Variable Message    \${:} = ${:}
    Check Variable Message    \${\\n} =
    Check Variable Message    \${cli_var_1} = CLI1
    Check Variable Message    \${cli_var_2} = CLI2
    Check Variable Message    \${cli_var_3} = CLI3
    Check Variable Message    \${DEBUG_FILE} = NONE
    Check Variable Message    \&{DICT} = { key=value | two=2 }
    Check Variable Message    \${ENDLESS} = repeat('RF')
    Check Variable Message    \${EXECDIR} = *    pattern=yes
    Check Variable Message    \${False} = *    pattern=yes
    Check Variable Message    \${ITERABLE} = <generator object <genexpr> at 0x*>    pattern=yes
    Check Variable Message    \@{LIST} = [ Hello | world ]
    Check Variable Message    \${LOG_FILE} = NONE
    Check Variable Message    \${LOG_LEVEL} = TRACE
    Check Variable Message    \${None} = None
    Check Variable Message    \${null} = None
    Check Variable Message    \&{OPTIONS} = { rpa=False | include=[] | exclude=[] | skip=[] | skip_on_failure=[] | console_width=78 }
    Check Variable Message    \${OUTPUT_DIR} = *    pattern=yes
    Check Variable Message    \${OUTPUT_FILE} = *    pattern=yes
    Check Variable Message    \${PREV_TEST_MESSAGE} =
    Check Variable Message    \${PREV_TEST_NAME} = Previous Test
    Check Variable Message    \${PREV_TEST_STATUS} = PASS
    Check Variable Message    \${REPORT_FILE} = NONE
    Check Variable Message    \${SCALAR} = Hi tellus
    Check Variable Message    \${SPACE} =
    Check Variable Message    \${SUITE_DOCUMENTATION} =
    Check Variable Message    \&{SUITE_METADATA} = { }
    Check Variable Message    \${SUITE_NAME} = *    pattern=yes
    Check Variable Message    \${suite_setup_global_var} = Global var set in suite setup
    Check Variable Message    \@{suite_setup_global_var_list} = [ Global var set in | suite setup ]
    Check Variable Message    \${suite_setup_suite_var} = Suite var set in suite setup
    Check Variable Message    \@{suite_setup_suite_var_list} = [ Suite var set in | suite setup ]
    Check Variable Message    \${SUITE_SOURCE} = *    pattern=yes
    Check Variable Message    \${TEMPDIR} = *    pattern=yes
    Check Variable Message    \${TEST_DOCUMENTATION} =
    Check Variable Message    \${TEST_NAME} = Log Variables
    Check Variable Message    \@{TEST_TAGS} = [ ]
    Check Variable Message    \${True} = *    pattern=yes
    Length Should Be    ${kw.messages}    41

Log Variables After Setting New Variables
    ${test} =    Check Test Case    Log Variables
    Set Test Variable    ${KW}    ${test[4]}
    Set Test Variable    ${INDEX}    ${1}
    Check Variable Message    \${/} = *    DEBUG    pattern=yes
    Check Variable Message    \${:} = ${:}    DEBUG
    Check Variable Message    \${\\n} =    DEBUG
    Check Variable Message    \${cli_var_1} = CLI1    DEBUG
    Check Variable Message    \${cli_var_2} = CLI2    DEBUG
    Check Variable Message    \${cli_var_3} = CLI3    DEBUG
    Check Variable Message    \${DEBUG_FILE} = NONE    DEBUG
    Check Variable Message    \&{DICT} = { key=value | two=2 }    DEBUG
    Check Variable Message    \${ENDLESS} = repeat('RF')    DEBUG
    Check Variable Message    \${EXECDIR} = *    DEBUG    pattern=yes
    Check Variable Message    \${False} = *    DEBUG    pattern=yes
    Check Variable Message    \@{int_list_1} = [ 0 | 1 | 2 | 3 ]    DEBUG
    Check Variable Message    \@{int_list_2} = [ 0 | 1 | 2 | 3 ]    DEBUG
    Check Variable Message    \${ITERABLE} = <generator object <genexpr> at 0x*>    DEBUG    pattern=yes
    Check Variable Message    \@{LIST} = [ Hello | world ]    DEBUG
    Check Variable Message    \${LOG_FILE} = NONE    DEBUG
    Check Variable Message    \${LOG_LEVEL} = TRACE    DEBUG
    Check Variable Message    \${None} = None    DEBUG
    Check Variable Message    \${null} = None    DEBUG
    Check Variable Message    \&{OPTIONS} = { rpa=False | include=[] | exclude=[] | skip=[] | skip_on_failure=[] | console_width=78 }    DEBUG
    Check Variable Message    \${OUTPUT_DIR} = *    DEBUG    pattern=yes
    Check Variable Message    \${OUTPUT_FILE} = *    DEBUG    pattern=yes
    Check Variable Message    \${PREV_TEST_MESSAGE} =    DEBUG
    Check Variable Message    \${PREV_TEST_NAME} = Previous Test    DEBUG
    Check Variable Message    \${PREV_TEST_STATUS} = PASS    DEBUG
    Check Variable Message    \${REPORT_FILE} = NONE    DEBUG
    Check Variable Message    \${SCALAR} = Hi tellus    DEBUG
    Check Variable Message    \${SPACE} =    DEBUG
    Check Variable Message    \${SUITE_DOCUMENTATION} =    DEBUG
    Check Variable Message    \&{SUITE_METADATA} = { }    DEBUG
    Check Variable Message    \${SUITE_NAME} = *    DEBUG    pattern=yes
    Check Variable Message    \${suite_setup_global_var} = Global var set in suite setup    DEBUG
    Check Variable Message    \@{suite_setup_global_var_list} = [ Global var set in | suite setup ]    DEBUG
    Check Variable Message    \${suite_setup_suite_var} = Suite var set in suite setup    DEBUG
    Check Variable Message    \@{suite_setup_suite_var_list} = [ Suite var set in | suite setup ]    DEBUG
    Check Variable Message    \${SUITE_SOURCE} = *    DEBUG    pattern=yes
    Check Variable Message    \${TEMPDIR} = *    DEBUG    pattern=yes
    Check Variable Message    \${TEST_DOCUMENTATION} =    DEBUG
    Check Variable Message    \${TEST_NAME} = Log Variables    DEBUG
    Check Variable Message    \@{TEST_TAGS} = [ ]    DEBUG
    Check Variable Message    \${True} = *    DEBUG    pattern=yes
    Check Variable Message    \${var} = Hello    DEBUG
    Length Should Be    ${kw.messages}    44

Log Variables In User Keyword
    ${test} =    Check Test Case    Log Variables
    Set Test Variable    ${KW}    ${test[5, 2]}
    Set Test Variable    ${INDEX}    ${1}
    Check Variable Message    \${/} = *    pattern=yes
    Check Variable Message    \${:} = ${:}
    Check Variable Message    \${\\n} =
    Check Variable Message    \${cli_var_1} = CLI1
    Check Variable Message    \${cli_var_2} = CLI2
    Check Variable Message    \${cli_var_3} = CLI3
    Check Variable Message    \${DEBUG_FILE} = NONE
    Check Variable Message    \&{DICT} = { key=value | two=2 }
    Check Variable Message    \${ENDLESS} = repeat('RF')
    Check Variable Message    \${EXECDIR} = *    pattern=yes
    Check Variable Message    \${False} = *    pattern=yes
    Check Variable Message    \${ITERABLE} = <generator object <genexpr> at 0x*>    pattern=yes
    Check Variable Message    \@{LIST} = [ Hello | world ]
    Check Variable Message    \${LOG_FILE} = NONE
    Check Variable Message    \${LOG_LEVEL} = TRACE
    Check Variable Message    \${None} = None
    Check Variable Message    \${null} = None
    Check Variable Message    \&{OPTIONS} = { rpa=False | include=[] | exclude=[] | skip=[] | skip_on_failure=[] | console_width=78 }
    Check Variable Message    \${OUTPUT_DIR} = *    pattern=yes
    Check Variable Message    \${OUTPUT_FILE} = *    pattern=yes
    Check Variable Message    \${PREV_TEST_MESSAGE} =
    Check Variable Message    \${PREV_TEST_NAME} = Previous Test
    Check Variable Message    \${PREV_TEST_STATUS} = PASS
    Check Variable Message    \${REPORT_FILE} = NONE
    Check Variable Message    \${SCALAR} = Hi tellus
    Check Variable Message    \${SPACE} =
    Check Variable Message    \${SUITE_DOCUMENTATION} =
    Check Variable Message    \&{SUITE_METADATA} = { }
    Check Variable Message    \${SUITE_NAME} = *    pattern=yes
    Check Variable Message    \${suite_setup_global_var} = Global var set in suite setup
    Check Variable Message    \@{suite_setup_global_var_list} = [ Global var set in | suite setup ]
    Check Variable Message    \${suite_setup_suite_var} = Suite var set in suite setup
    Check Variable Message    \@{suite_setup_suite_var_list} = [ Suite var set in | suite setup ]
    Check Variable Message    \${SUITE_SOURCE} = *    pattern=yes
    Check Variable Message    \${TEMPDIR} = *    pattern=yes
    Check Variable Message    \${TEST_DOCUMENTATION} =
    Check Variable Message    \${TEST_NAME} = Log Variables
    Check Variable Message    \@{TEST_TAGS} = [ ]
    Check Variable Message    \${True} = *    pattern=yes
    Check Variable Message    \${ukvar} = Value of an uk variable
    Length Should Be    ${kw.messages}    42

List and dict variables failing during iteration
    Check Test Case    ${TEST NAME}

*** Keywords ***
Check Variable Message
    [Arguments]    ${expected}    ${level}=INFO    ${pattern}=
    Check Log Message    ${KW[${INDEX}]}    ${expected}    ${level}    pattern=${pattern}
    Set Test Variable    ${INDEX}    ${INDEX + 1}
