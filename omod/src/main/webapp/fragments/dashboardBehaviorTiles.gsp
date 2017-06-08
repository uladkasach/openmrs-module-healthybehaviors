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
    .behavior_tile_header_image {
      width:100%;
      height:100%;
      background-size: cover;
      background-position: center center;
      background-repeat: no-repeat;
      /* background-image:  url('http://unsplash.it/1200x800'); */
      
    }
    .behavior_tile_header_image:before{
      content: '';
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      background-image: linear-gradient(to bottom right,#002f4b,rgba(183, 183, 183, 0.83));
      opacity: .6; 
    }
    
    .nutritionHeaderImage{
      background-image:  ; 
    }
</style>

<script>
    
window.addEventListener("load", function(){
    var requested_behaviors = [];
    
    // TODO - create general way of initializing requested tiles based on JSON data passed from server of behaviors of interest to this loading of the module
    
    ////////////////////////
    // Nutrition Tile
    ////////////////////////
    var nutrition_behavior = new abstract_behavior_class();
    nutrition_behavior.wow_facts =  [
        "adding citrus juice to green tea stabalizes its catechin content, boosting the level of antioxidants that survive the digestive system up to 13-fold",
        "a 20oz bottle of Coca-Cola has more suggar than a large Cinnabon",
        "one third of Americans get 47 percent of their calories from junk foods",
        "the average American is eating 300 more calories each day than he or she did in 1985",
        "trials found a 5-12 percent decrease in cholesterol levels in hyperlipidemic patients after at least 30 days’ treatment with 600-900 mg of garlic extract",
        "ten cups per day of green tea delayed cancer onset 8.7 years in Japanese women and three years in Japanese men",
    ];
    nutrition_behavior.unique_behavior_id = "nutrition";
    nutrition_behavior.header_title_text = "Nutrition <br> & Diet";
    nutrition_behavior.header_background_image_src = '${ ui.resourceLink("healthybehaviors", "/images/beauty_berries.jpeg") }';
    nutrition_behavior.advice_type_text = "Nutrition and Diet";
    nutrition_behavior.uptodate = true;
    nutrition_behavior.time_interval = "week";
    nutrition_behavior.chart = {
        type : "line",
        labels: ["-3 Week", "-2 Week", "Last Week"],
        datasets : [{
                    label: 'Veggies Eaten',
                    data: [7, 12, 9],
                    backgroundColor: [
                        'rgba(99, 255, 135, 0.2)',
                    ],
                    borderColor: [
                        'rgb(99, 255, 135)',
                    ],
                    borderWidth: 1
                },{
                    label: 'Fast Food Eaten',
                    data: [3, 0, 1],
                    backgroundColor: [
                        'rgba(255, 62, 62, 0.1)',
                    ],
                    borderColor: [
                        'rgb(255, 62, 62)',
                    ],
                    borderWidth: 1
                }],
        options :  {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        },
    }
    requested_behaviors.push(nutrition_behavior);
    
    /////////////////////////
    // Exercise Tile
    /////////////////////////
    var exercise_behavior = new abstract_behavior_class();
    exercise_behavior.wow_facts =  [
        "working out sharpens your memory",
        "exercise prevents signs of aging",
        "working out helps you sleep better",
        "on average, it takes about 12 weeks after beginning to exercise to see measurable changes in your body",
        "exercise is more effective at increasing your energy levels than caffeine",
    ];
    exercise_behavior.unique_behavior_id = "exercise";
    exercise_behavior.header_title_text = "Exercise";
    exercise_behavior.header_background_image_src = '${ ui.resourceLink("healthybehaviors", "/images/runner.jpeg") }';
    exercise_behavior.advice_type_text = "Exercise";
    exercise_behavior.uptodate = false;
    exercise_behavior.time_interval = "week";
    exercise_behavior.chart = {
        type: "radar",
        labels : ["Strength","Flexibility","Vigorous","Moderate", "Light"],
        datasets : [
            {
                label: '-2 Week',
                data: [3, 3, 2, 4, 3],
                backgroundColor: [
                    'rgba(1, 119, 199, 0.1)',
                ],
                borderColor: [
                    'rgba(1, 119, 199, 1)',
                ],
                borderWidth: 1
            },{
                label: '-3 Week',
                data: [2, 4, 1, 5, 3],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.1)',
                ],
                borderColor: [
                    'rgba(54, 162, 235, 0.8)',
                ],
                borderWidth: 1
            }
                /*,{
                label: '-2 W',
                data: [1, 2, 3, 3, 2],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.1)',
                ],
                borderColor: [
                    'rgba(54, 162, 235, 0.6)',
                ],
                borderWidth: 1
            }*/
       ],
        options :  {
            scale: {
                ticks: {
                    min: 0,
                    minStepSize: 1,
                }
            }
        },
    }
    requested_behaviors.push(exercise_behavior);
    
    
    behavior_tile_builder_singleton.tile_template = document.getElementById("behavior_tile_hidden_template");
    behavior_tile_builder_singleton.tile_holder = document.getElementById("dashboard_behavior_tile_holder");
    for(var i = 0; i < requested_behaviors.length; i++){
        behavior_tile_builder_singleton.build_tile_and_add_to_holder(requested_behaviors[i]);
    }
});
    
    
var behavior_tile_builder_singleton = {
    tile_holder : null,
    template_wrapper : null, // defines the DOM object which wraps the template and which will be manipulated to build individualized tiles
    
    build_tile_and_add_to_holder : function(abstract_behavior_object){
        var a_tile = this.tile_template.cloneNode(true);
        
        // Set tile id
        a_tile.id = abstract_behavior_object.unique_behavior_id + "-behavior_tile";
        
        // Set header title
        jq(a_tile).find(".behavior_tile_header_text")[0].innerHTML = abstract_behavior_object.header_title_text;
        
        // Set header background image
        jq(a_tile).find(".behavior_tile_header_image")[0].style.backgroundImage = 'url(' + abstract_behavior_object.header_background_image_src + ')';
        
        // Set wow fact
        jq(a_tile).find(".behavior_tile_wow_fact")[0].innerHTML = abstract_behavior_object.wow_fact;
        
        // Set advice_type_text to EACH behavior_tile_advice_type_text
        jq(a_tile).find(".behavior_tile_advice_type_text").html(abstract_behavior_object.advice_type_text);
        
        // set behavior_tile_time_interval text
        jq(a_tile).find(".behavior_tile_time_interval").html(abstract_behavior_object.time_interval)
        
        // set html
        this.tile_holder.appendChild(a_tile);
        
        // update tile graph data to uptodate status
        if(abstract_behavior_object.uptodate == true){
            console.log("here i am");
            console.log(jq(a_tile).find(".behavior_tile_response_uptodate"));
            jq(a_tile).find(".behavior_tile_response_uptodate").css('display', 'block');
        } else {
            jq(a_tile).find(".behavior_tile_response_outofdate").css('display', 'block');
        }
        
        // update tile action buttons to uptodate status
        if(abstract_behavior_object.uptodate !== true) jq(a_tile).find(".behavior_tile_call_to_action_button")[0].className += " behavior_tile_button_call_to_action_modifier";
        
        // insert links to respective advice/history and form views
        jq(a_tile).find(".behavior_tile_form_anchor").attr('href','/record_performance.page?'+abstract_behavior_object.unique_behavior_id);
        jq(a_tile).find(".behavior_tile_advice_history_anchor").attr('href','/advice_and_history.page?'+abstract_behavior_object.unique_behavior_id);
        
        
        // initialize the chart 
        this.initialize_graphs(abstract_behavior_object);
    },
    
    initialize_graphs : function(abstract_behavior_object){
        var reference_element = document.getElementById(abstract_behavior_object.unique_behavior_id + "-behavior_tile");
        var chart_canvas = (jq(reference_element).find(".behavior_tile_mini_chart")[0]);
        var ctx = chart_canvas.getContext('2d');
        console.log(ctx);
        new Chart(ctx, {
            type: abstract_behavior_object.chart.type,
            data: {
                labels: abstract_behavior_object.chart.labels, //["-5 W", "-4 W", "-3 W", "-2 W", "-1 W", "Now", "-5 W", "-4 W", "-3 W", "-2 W", "-1 W", "Now"],
                datasets: abstract_behavior_object.chart.datasets, 
            },
            options: abstract_behavior_object.chart.options,
        });
    }
    
}

    
</script>



<script>
</script>

<!-- tile container/holder -->
<div class = 'offset_from_top_if_not_in_iframe' style = 'min-height:90%;  '>
    <div id = 'dashboard_behavior_tile_holder' style = 'display:flex; flex-wrap: wrap; justify-content:center; margin:auto;  width:100%;'>

    </div>
</div>


<!-- tile template -->
<style>
    a, a:hover, a:focus {
        color: inherit;
        text-decoration: none;
    }
    .behavior_highlighed_interest{
        font-weight:bold;
        color:rgb(8, 160, 255);
    }
    .behavior_highlighed_interest:hover{
        color:rgb(8, 160, 255);
    }
    .behavior_tile_button{
        cursor:pointer;
        border:1px solid white;
        border-radius:2px;
        color:rgb(8, 160, 255);
    }
    .behavior_tile_button:hover{
        background-color:rgba(0, 191, 255, 0.1);
        color:rgb(8, 160, 255);
    }
    .behavior_tile_button_call_to_action_modifier{
        border-color:rgb(8, 160, 255);
    }
    .behavior_tile_button_call_to_action_modifier:hover{
        background-color:rgba(0, 191, 255, 0.1);
    }
    .behavior_tile_form_anchor{
        cursor:pointer;
    }
    .behavior_tile_advice_history_anchor{
        cursor:pointer;
    }

</style>
<div id = ''  style = 'display:none'>
    <div  id = 'behavior_tile_hidden_template' class = 'behavior_tile_reference_element' style = 'flex: 1 300px; max-width:400px; margin:20px 10px; '>
        <!-- tile header -->
        <div style = 'width:100%; height:225px; position:relative;'>
            <!-- gradient overly element will be inserted by css (:before) into this location -->
            <div class = 'behavior_tile_header_image' style = 'display:flex;'>
                <div class = 'behavior_tile_header_text' style = 'margin:auto;'>
                    ---
                </div>
            </div>
        </div>


        <div style = 'height:10px;'></div>
        
        <!-- tile draw-in -->
        <div style = 'width:100%; height:80px;  display:flex;'>
                <div style = 'margin:auto; text-align:center; padding-top:5px; padding-bottom:5px;'>
                    <span class = 'behavior_tile_wow_fact'> --- </span>
                </div>
        </div>
        
        <!-- divider -->
        <div style = 'height:10px;'></div>
        <div style = 'display:flex;'>
            <div style = 'margin:auto; width:90%; border-bottom:1px solid rgba(128, 128, 128, 0.17);'></div>
        </div>
        <div style = 'height:15px;'></div>
        
        <!-- tile draw-in -->
        <div style = 'width:100%; min-height:100px; display:flex; padding:5px;'>
            <div style = 'display:flex;'>
                <div style = 'margin:auto; text-align:center;'>
                    <canvas class="behavior_tile_mini_chart" width="175" height="175"></canvas>
                </div>
            </div>
            <div style = 'width:15px;'></div>
            <div style = 'flex:1; display:flex;'>
                <div class = 'behavior_tile_response_uptodate' style = 'margin:auto; display:none; text-align:center; font-size:14px;'>
                    You did great last week. Proper <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> will  {insert reason why to care}
                </div>
                <div class = 'behavior_tile_response_outofdate' style = 'margin:auto; display:none; text-align:center; font-size:14px;'>
                    <a class = 'behavior_highlighed_interest behavior_tile_form_anchor' style = 'display:inline-block;'>Record your <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> data for the previous <span class = 'behavior_tile_time_interval'></span></a> to personalize your advice and track your performance.
                </div>
            </div>
        </div>
        
        <!-- divider -->
        <div style = 'height:15px;'></div>
        <div style = 'display:flex;'>
            <div style = 'margin:auto; width:90%; border-bottom:1px solid rgba(128, 128, 128, 0.17);'></div>
        </div>
        <div style = 'height:10px;'></div>

        <!-- links to forms and advice -->
        <div style = 'font-size:14px;'>
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
                        View your <span class = 'behavior_highlighed_interest'> personalized <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> advice </span> and your  <span class = 'behavior_highlighed_interest'> full performance history </span> here
                    </div>
                </div> 
            </a>
            <div style = 'height:5px;'></div>
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
                        Record your <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> performance for the previous <span class = 'behavior_tile_time_interval'></span>
                    </div>
                    <div class = 'behavior_tile_response_uptodate' style = 'margin:auto; display:none;'>
                        Update the <span class = 'behavior_tile_advice_type_text' style = 'text-transform: lowercase;'></span> data you recorded for the previous <span class = 'behavior_tile_time_interval'></span>
                    </div>
                </div> 
            </a>
        </div>

    </div>
</div>