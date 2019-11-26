# Check Lists

Various check lists to use during the competition.

If you have a checklist you want to update or add, you can either contact the repository maintainer with the changes, or you can use `git` to make the changes and open a PR.

## Image Flow

1. Start and register the team ID
2. Read the Scenario and accompaning information for hints and details.
3. Review Forensic questions and research what is needed to answer them.

## Access Control

### Users

* Check that all users are authorized for access to the system.
    * Remove non-authorized users.
    * Keep files in for forensic analysis (or recovery)
    * *Caution* Do not remove service accounts.
* Check local users with admnistrator permissions are authorized administrators.
    * If not authorized, change user type to local user.
* Check authorized admnistrators are listed with administrator permissions.
    * If not, Change user type to local administrator.
* Check that all acounts have passwords assigned.
    * Create a password for accounts with out passwords.
    * For competition, Write down account name and password assigned.
* Check that the administrator account has been renamed. (Windows)
    * `Administrator` account does not have administrative permissions.
    * Another account is listed as built-in with administrative permissions.


### Passwords

* Check that password requirements are enforced to mininum recommendation.
    * Mininum length:  10 characters or more.
    * Maximum age:  90 days or less.
    * Mininum age:  1 day or more.
    * Password history:  10 passwords or more.
    * *Caution* Do not set rules to values that may lock the accounts out.
* Check that account lockouts are enforced.
    * Threshold:  5 bad passwords or less.
    * Duration:  15 minutes or more.
## Files and Folders

### Files

* Search and remove media files that are not part of the OS.
  * Extensions: mp3, mpeg, mp4, png, jpg, gif.
  * Kind: music, movies, pictures
  * *Caution* Be careful of removing from system or program folders.
  * *Caution* May want to consider moving file before deletion.




### Complete?

* Do you have all of the points?
* Were the Forensic Questions answered?
* Were all checklists reviewed?
