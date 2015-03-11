@ignore @updatePayment @acceptance
Feature: Update Payment Modal
Users with expired card or last payment failed get modal
Button on modal to update payment
No thanks link to close modal for 24 hours
User whose card is not expired and has not failed does not get modal

Background:
#	Given I have no browser cookies
	Given I am on the USCP home page
	Then The homepage loads
	When I hover on the Firefly Login icon
		And I click Log in in pushdown
	Then the log in page loads

@s1
Scenario Outline: Update Payment modal for expired or payment failed accounts
	When I log in with "<email>" and "<password>"
	Then Logins with "<payment_status>" should "<show_modal>"
	When I hover on the Firefly Login icon
  		And I log out
	Then The homepage loads
Examples:
      | payment_status       |  email                        | password    |  show_modal               |
      | expired              |  DC4834301@mailinator.com     | New1111     |  yes                      |
      | lastpaymentfailed    |  DC2753260@mailinator.com     | New1111     |  yes                      |
      | nullexp              |  DC15022302@mailinator.com    | New1111     |  no                       |
      | futureexp            |  DC15022302@mailinator.com    | New1111     |  no                       |
      | lastpaymentnotfailed |  DC15022302@mailinator.com    | New1111     |  no                       |
@s2
Scenario: Update Payment links to SAM page
	When I log in with "DC4834301@mailinator.com" and "New1111"
	Then Update Your Payment Information modal displays
	When I click "update your payment information" link
	Then Update Your Payment Information modal does not display
		And A new window for the SAM Change Your Payment page opens
	When The homepage loads
		And I hover on the Firefly Login icon
		And I log out
	Then The homepage loads
	When I hover on the Firefly Login icon
		And I click Log in in pushdown
	Then the log in page loads
	When I log in with "DC4834301@mailinator.com" and "New1111"
	Then Update Your Payment Information modal does not display
	When I hover on the Firefly Login icon
		And I log out
	Then The homepage loads

@s3
Scenario: Remind me Later closes modal
	When I log in with "DC2753260@mailinator.com" and "New1111"
	Then Update Your Payment Information modal displays
	When I click "remind me later" link
	Then Update Your Payment Information modal does not display
	When I hover on the Firefly Login icon
		And I log out
	Then The homepage loads
