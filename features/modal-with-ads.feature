@ignore @uscp
Feature: Update Payment Modal
	Users with expired card or last payment failed get modal
	Button on modal to update payment
	No thanks link to close modal for 24 hours
	User whose card is not expired and has not failed does not get modal

@modal-with-ads
Scenario Outline: Verify the modal window along with a gravity AD
#	Given I have no browser cookies
	Given I am on the USCP home page
#	Given I am on the USCP home page with "<ad_type>" AD
	Then The "<ad_type>" AD displays
	When I hover on the Firefly Login icon
		And I click Log in in pushdown
	Then the log in page loads
	When I log in with "DC4834301@mailinator.com" and "New1111"
#	Then Update Your Payment Information modal displays
	Then Locate the leave behind AD
	When I hover on the Firefly Login icon
		And I log out
	Then The homepage loads

Examples:
| ad_type |
#| Gravity |
#| Billboard |
| Pushdown |
#| Takeover |

@modal-without-ads
Scenario: The modal window displays if no high-impact ads are configured for the site
	Given I am on the USCP home page
	When I hover on the Firefly Login icon
		And I click Log in in pushdown
	Then the log in page loads
	When I log in with "DC4834301@mailinator.com" and "New1111"
	Then Update Your Payment Information modal displays
	When I hover on the Firefly Login icon
		And I log out
	Then The homepage loads
