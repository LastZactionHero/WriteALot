/**
 *  Managing Invitations
 */

/**
 * Add New Invitation
 */
function inviteAdd
(
		inInputId
)
{
	if( sDefaultInvitationText )
		return;

	username = String( document.getElementById( inInputId ).value );
	username = encodeURIComponent( username );

	if( username.length > 0 )
	{
		window.location = "/users/invite_add/" + encodeURIComponent( username );
	}
}

/**
 * Accept Invitation
 */
function inviteAccept
(
		inId
)
{
	window.location = "/users/invite_accept/" + inId;
}

/** 
 * Ignore Invite
 */
function inviteIgnore
(
		inId
)
{
	window.location = "/users/invite_ignore/" + inId;
}

/**
 * Delete Invitation
 */
function inviteDelete
(
		inId
)
{
	var deleteConfirmation = confirm ( "Are you sure you would like to remove this contact?" );
	if( deleteConfirmation )
	{
		window.location = "/users/invite_delete/" + inId;
	}
}

/** 
 * Remove Default Invitation Text
 */
sDefaultInvitationText = true;
function invitationTextClicked
(
		inInputId
)
{
	if( sDefaultInvitationText )
	{
		sDefaultInvitationText = false;
		document.getElementById( inInputId ).value = "";
	}
}