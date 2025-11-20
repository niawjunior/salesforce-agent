<aura:application extends="force:slds">
    <aura:attribute name="genderOptions" type="String[]" />
    <aura:attribute name="selectedGender" type="String" />
    <aura:attribute name="errorMessage" type="String" />
    <aura:attribute name="infoMessage" type="String" />

    <!-- Initialize the component -->
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>

    <div class="slds-box slds-theme_default">
        <h2 class="slds-text-heading_small slds-m-bottom_medium">Gender Identity Selector</h2>

        <!-- Info Message Display -->
        <div aura:if="{!v.infoMessage}" class="slds-notify slds-notify_alert slds-theme_alert-texture slds-m-bottom_medium" role="alert">
            <span class="slds-assistive-text">info</span>
            <span class="slds-icon_container slds-m-right_x-small">
                <lightning:icon iconName="utility:info" size="x-small" alternativeText="info"/>
            </span>
            {!v.infoMessage}
        </div>

        <!-- Error Message Display -->
        <div aura:if="{!v.errorMessage}" class="slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_warning slds-m-bottom_medium" role="alert">
            <span class="slds-assistive-text">error</span>
            <span class="slds-icon_container slds-m-right_x-small">
                <lightning:icon iconName="utility:error" size="x-small" alternativeText="error"/>
            </span>
            {!v.errorMessage}
        </div>

        <!-- Gender Selection Section -->
        <div class="slds-section slds-is-open">
            <h3 class="slds-section__title slds-theme_shade">
                <span class="slds-truncate slds-p-horizontal_small" title="Select Gender Identity">Select Gender Identity</span>
            </h3>
            <div class="slds-section__content">
                <div aura:if="{!v.genderOptions.length > 0}">
                    <div class="gender-picker">
                        <aura:iteration items="{!v.genderOptions}" var="gender">
                            <button class="{!'slds-button slds-button_neutral gender-btn ' + (v.selectedGender == gender ? 'selected' : '')}"
                                    onclick="{!c.selectGender}"
                                    data-gender="{!gender}">
                                {!gender}
                            </button>
                        </aura:iteration>
                    </div>

                    <!-- Selected Gender Display -->
                    <div aura:if="{!v.selectedGender}" class="slds-m-top_medium">
                        <p class="slds-text-heading_small">Selected: {!v.selectedGender}</p>
                    </div>
                </div>
                
                <!-- No options available message -->
                <div aura:if="{!v.genderOptions.length == 0 &amp;&amp; !v.errorMessage}" class="slds-text-body_regular slds-text-color_weak">
                    No options are available. This could mean:
                    <ul class="slds-list_dotted">
                        <li>The GenderIdentity field doesn't exist on the Lead object</li>
                        <li>You don't have permission to access this field</li>
                        <li>The field is not a picklist type</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</aura:application>
