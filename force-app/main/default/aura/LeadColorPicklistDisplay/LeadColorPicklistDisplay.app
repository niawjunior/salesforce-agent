<aura:application extends="force:slds" controller="LeadColorPicklistDisplayController">
    <aura:attribute name="picklistOptions" type="String[]" />
    <aura:attribute name="selectedColor" type="String" />

    <!-- Initialize the component -->
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>

    <div class="slds-box slds-theme_default">
        <h2 class="slds-text-heading_small slds-m-bottom_medium">Lead Color Picker</h2>

        <!-- Color Selection Section -->
        <div class="slds-section slds-is-open">
            <h3 class="slds-section__title slds-theme_shade">
                <span class="slds-truncate slds-p-horizontal_small" title="Select Color">Select Color</span>
            </h3>
            <div class="slds-section__content">
                <div class="color-picker">
                    <aura:iteration items="{!v.picklistOptions}" var="color">
                        <button class="{!'slds-button slds-button_neutral color-btn ' + (v.selectedColor == color ? 'selected' : '')}"
                                onclick="{!c.selectColor}"
                                data-color="{!color}">
                            <span class="{!'color-indicator ' + color}"></span>
                            {!color}
                        </button>
                    </aura:iteration>
                </div>

                <!-- Selected Color Display -->
                <div aura:if="{!v.selectedColor}" class="slds-m-top_medium">
                    <p class="slds-text-heading_small">Selected Color: {!v.selectedColor}</p>
                </div>
                <div aura:if="{!not(v.selectedColor)}">
                    <p class="slds-text-heading_small">Please select a color</p>
                </div>
            </div>
        </div>
    </div>
</aura:application>
