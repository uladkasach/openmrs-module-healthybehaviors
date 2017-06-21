<!-- 
    This file should contain the UI for the tiles on the dashboard page.
    Each tile should have similar structure.
-->

<style>
    .behavior_tile_header_text{
        font-size:32px;
        color:white;
        font-weight:bold;
        z-index:1; /* required to maintain text above the gradient overlay generated by behaviorTileHeaderImage:before */
        text-align:center;
    }
    
</style>

<script>
    
window.addEventListener("load", function(){
    setTimeout(function(){ // TODO - after passing data from server, remove this. Currently this is here because we are loading JSON data on client asynchronously.
        var requested_behaviors = [];
        // TODO - create general way of initializing requested tiles based on JSON data passed from server of behaviors of interest to this loading of the module

        ////////////////////////
        // Nutrition Tile
        ////////////////////////
        requested_behaviors.push(window["loaded_behaviors"]["nutrition"]);

        /////////////////////////
        // Exercise Tile
        /////////////////////////
        requested_behaviors.push(window["loaded_behaviors"]["exercise"]);

        behavior_tile_builder_singleton.tile_template = document.getElementById("behavior_tile_hidden_template");
        behavior_tile_builder_singleton.tile_holder = document.getElementById("dashboard_behavior_tile_holder");
        for(var i = 0; i < requested_behaviors.length; i++){
            behavior_tile_builder_singleton.build_tile_and_add_to_holder(requested_behaviors[i]);
        }
    },50);
});
    
</script>



<script>
</script>

<!-- tile container/holder -->
<div class = '' style = 'min-height:90%;  '>
    <div id = 'dashboard_behavior_tile_holder' style = 'display:flex; flex-wrap: wrap; justify-content:center; margin:auto;  width:100%;'>

    </div>
</div>


<!-- tile template -->
<style>
</style>
<div id = ''  style = 'display:none'>
<div id = 'behavior_tile_hidden_template' style = 'flex: 1 300px; max-width:500px; margin:10px 5px;'>
    <div  id = '' class = 'behavior_tile_reference_element healthy_tile' style = ' margin:10px 10px; '>
        <!-- tile header -->
        <div style = 'width:100%; height:225px; position:relative;'>
            <!-- gradient overly element will be inserted by css (:before) into this location -->
            <div class = 'behavior_tile_header_image image_element_to_place_gradient_over' style = 'display:flex;'>
                <div class = 'behavior_tile_header_text' style = 'margin:auto;'>
                    ---
                </div>
            </div>
        </div>
    </div>

    <div  id = '' class = 'behavior_tile_reference_element healthy_tile' style = ' margin:10px 10px;  padding:10px; '>

            <!-- tile draw-in -->
            <div style = 'width:100%; height:80px;  display:flex; font-size:14px;'>
                    <div style = 'margin:auto; text-align:center; padding-top:5px; padding-bottom:5px;'>
                        <span class = 'behavior_tile_wow_fact'> --- </span>
                    </div>
            </div>

    </div>
    <div  id = '' class = 'behavior_tile_reference_element healthy_tile' style = 'margin:10px 10px;  padding:20px 10px;'>

            <!-- tile draw-in -->
            <div style = 'width:100%; min-height:100px; display:flex; padding:5px;'>
                <div style = 'display:flex;'>
                    <div style = 'margin:auto; text-align:center;'>
                        <canvas class="behavior_tile_mini_chart" width="200" height="200"></canvas>
                    </div>
                </div>
                <div style = 'width:15px;'></div>
                <div style = 'flex:1; display:flex;'>
                    <div class = 'behavior_tile_response_uptodate' style = 'margin:auto; display:none; text-align:center; '>
                        You did great last week. Proper <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> will  {insert reason why to care}
                    </div>
                    <div class = 'behavior_tile_response_outofdate' style = 'margin:auto; display:none; text-align:center; font-size:14px;'>
                        <a class = 'behavior_highlighed_interest behavior_tile_form_anchor' style = 'display:inline-block;'>Record your <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> data for the previous <span class = 'behavior_tile_time_interval'></span></a> to personalize your advice and track your performance.
                    </div>
                </div>
            </div>

    </div>
    <div  id = '' class = 'behavior_tile_reference_element healthy_tile' style = 'margin:5px 10px; '>
        
                <a style = 'padding:10px; display:flex;' class = 'behavior_tile_button behavior_tile_advice_history_anchor'>
                    <div style = 'display:flex; min-width:35px;'>
                        <div style = 'margin:auto; '>
                            <!-- <img src = '${ ui.resourceLink("healthybehaviors", "/images/record_icon.png") }' style = 'width:35px;'> -->
                            <span class = 'glyphicon glyphicon-fullscreen' style = 'font-size:21px;'></span>
                        </div>
                    </div> 
                    <div style = 'min-width:10px;'></div>
                    <div style = 'display:flex;'>
                        <div style = 'margin:auto;'>
                            View your <span class = ''> personalized </span>  <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> <span class = ''> advice</span>  and your  full performance <span class = ''>history </span> here
                        </div>
                    </div> 
                </a>
                
                <a style = 'padding:10px; display:flex;' class = 'behavior_tile_button behavior_tile_call_to_action_button behavior_tile_form_anchor'>
                    <div style = 'display:flex; min-width:35px;'>
                        <div style = 'margin:auto; '>
                            <!-- <img src = '${ ui.resourceLink("healthybehaviors", "/images/record_icon.png") }' style = 'width:35px;'> -->
                            <span class = 'glyphicon glyphicon-pencil' style = 'font-size:21px;'></span>
                        </div>
                    </div> 
                    <div style = 'min-width:10px;'></div>
                    <div style = 'display:flex;'>
                        <div class = 'behavior_tile_response_outofdate' style = 'margin:auto; display:none;'>
                            Record how your last <span class = 'behavior_tile_time_interval'></span> went, <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> wise, to personalize your advice and history
                        </div>
                        <div class = 'behavior_tile_response_uptodate' style = 'margin:auto; display:none;'>
                            Update the <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> data you recorded for the previous <span class = 'behavior_tile_time_interval'></span> if you remembered any changes
                        </div>
                    </div> 
                </a>
    </div>
</div>
</div>