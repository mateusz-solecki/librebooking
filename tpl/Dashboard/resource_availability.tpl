<div class="dashboard accordion-item shadow mb-2 availabilityDashboard" id="availabilityDashboard">
    <div class="accordion-header dashboardHeader">
        <button class="accordion-button collapsed link-primary fw-bold" type="button" data-bs-toggle="collapse"
            data-bs-target="#ResourceAvailabilityContents" aria-expanded="false"
            aria-controls="ResourceAvailabilityContents">
            Zarezerwuj salę
        </button>
    </div>

    <div id="ResourceAvailabilityContents" class="dashboardContents accordion-collapse collapse">
        <div class="accordion-body">

            {assign var=allFlatItems value=[]}
            {foreach from=$Schedules item=s}
                {if isset($Available[$s->GetId()]) && is_array($Available[$s->GetId()])}
                    {foreach from=$Available[$s->GetId()] item=i}
                        {$allFlatItems[] = $i}
                    {/foreach}
                {/if}
                {if isset($Unavailable[$s->GetId()]) && is_array($Unavailable[$s->GetId()])}
                    {foreach from=$Unavailable[$s->GetId()] item=i}
                        {$allFlatItems[] = $i}
                    {/foreach}
                {/if}
                {if isset($UnavailableAllDay[$s->GetId()]) && is_array($UnavailableAllDay[$s->GetId()])}
                    {foreach from=$UnavailableAllDay[$s->GetId()] item=i}
                        {$allFlatItems[] = $i}
                    {/foreach}
                {/if}
            {/foreach}

            {if $allFlatItems|count > 0}
                <div class="row">
                    {foreach from=$allFlatItems item=i}
                        <div class="col-12 col-sm-6">
                            <div class="availabilityItem">
                                    <a resource-id="{$i->ResourceId()}" class="resourceNameSelector"
                                        href="{$Path}{Pages::RESERVATION}?{QueryStringKeys::RESOURCE_ID}={$i->ResourceId()}">
                                        {$i->ResourceName()}
                                    </a>

                            </div>
                        </div>
                    {/foreach}
                </div>
            {else}
                <div class="no-data text-center fst-italic fs-5 py-3">
                    {translate key=None}
                </div>
            {/if}

        </div>
    </div>
</div>
