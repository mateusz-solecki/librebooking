{assign var=checkin value=$reservation->IsCheckinEnabled() && $reservation->RequiresCheckin()}
{assign var=checkout value=$reservation->IsCheckinEnabled() && $reservation->RequiresCheckout()}
{assign var=class value=""}
{if $reservation->RequiresApproval}{assign var=class value="pending"}{/if}
<div class="reservation row gx-0 {$class} border-bottom p-2 border-bottom align-items-center {if isset($orangePending)}bg-white{/if}"
    id="{$reservation->ReferenceNumber}">
    {*doesn't show pending approval reservations as orange in the Pending Approval Reservations displayer in the dashboard*}
    <div class="col-sm-3 col-12"> {$reservation->ResourceNames|join:', '}
        <div class="reservationAttributes small text-muted"></div>
    </div>
    <div class="col-sm-3 col-6">{$reservation->StartDate->ToTimezone($Timezone)->Format('d.m.Y')}</div>
    <div class="col-sm-3 col-6">{$reservation->StartDate->ToTimezone($Timezone)->Format('H:i')} - {$reservation->EndDate->ToTimezone($Timezone)->Format('H:i')}</div>
    {if $reservation->Title}
    <div class="col-sm-3 col-12">
        <span class="reservationTitleMod">{$reservation->Title|escape:'html'|default:$DefaultTitle}</span>
    </div>
    {/if}
    {*<div class="col-sm-2 col-6">{if !$reservation->IsUserOwner($UserId)}<i class="bi bi-people-fill"></i> {/if}</div>
     *}



</div>

{literal}
<script type="text/javascript">
$(function () {
    if (window.__attrInit) return;
    window.__attrInit = true;

    var cache = {};

    function clean(s) {
        return $.trim((s || '').replace(/\s+/g, ' '));
    }

    // tylko atrybuty własne, blok akcesoriów jest pomijany
    function parseAttributes(html) {
        var values = [];
        $('<div>').html(html).find('.attributes-block .form-group').each(function () {
            var value = clean($(this).find('.attributeValue').first().text());
            if (value) values.push(value);
        });
        return values;
    }

    $('.reservation[id]').each(function () {
        var $target = $(this).find('.reservationAttributes');
        var id = this.id;
        if (!$target.length || !id) return;

        if (cache[id] === undefined) {
            cache[id] = $.get('ajax/respopup.php', { id: id });
        }
        cache[id].done(function (html) {
            var values = parseAttributes(html);
            if (!values.length) return;

            $target.empty()
                .append('<i class="bi bi-tag-fill"></i> ')
                .append(document.createTextNode(values.join(', ')));
        });
    });
});
</script>
{/literal}
