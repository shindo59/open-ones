/**
 * Submit the form.
 * @param frmName
 * @param eventId
 * @return
 */
function submitAction(frmName, eventId) {
	var frm = document.forms[frmName];
	frm.eventId.value = eventId;
	frm.submit();
}
/**
 * Submit the form.
 * @param frmName
 * @param screenId
 * @param eventId
 * @return
 */
function submitAction(frmName, screenId, eventId) {
    var frm = document.forms[frmName];
    frm.screenId.value = screenId;
    frm.eventId.value = eventId;
    frm.submit();
}
