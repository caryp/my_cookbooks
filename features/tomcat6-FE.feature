Feature: webapp test
  Tests the RightScale app stack

  Scenario: Basic test

    Given A deployment named "Regression Test - tomcat6"
    And "2" operational servers named "Tomcat6 FE set1"

    When I run "test -e /home/haproxy/haproxy" on all servers
    Then it should exit successfully on all servers

    When I run "service haproxy restart" on all servers
    Then it should exit successfully on all servers

    When I run "service haproxy check" on all servers
    Then it should exit successfully on all servers

    When I run "pgrep haproxy" on all servers
    Then it should exit successfully on all servers

    When I run "apachectl -t" on all servers
    Then it should exit successfully on all servers

    When I query "/" on all servers 
    Then I should see "html serving succeeded." in all the responses

    When I query "/appserver" on all servers
    Then I should see "configuration=succeeded" in all the responses 

    When I query "/dbread" on all servers
    Then I should see "I am in the db" in all the responses

    When I query "/foo" on all servers
    Then I should see "HTTP Status 404" in all the responses
    
    When I query "/foo" on all servers
    Then I should not see "asdf" in all the responses

    When I run "test -d /mnt/log/tomcat6" on all servers
    Then it should exit successfully on all servers

    When I run "test -L /var/log/tomcat6" on all servers
    Then it should exit successfully on all servers

    When I run "test -d /home/webapps/tomcatapp/current/apptest" on all servers
    Then it should exit successfully on all servers

    When I run "test -f /etc/logrotate.d/tomcat6" on all servers
    Then it should exit successfully on all servers

#    When I run "" on all servers
#    Then it should exit successfully on all servers
