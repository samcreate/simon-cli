<?php
// API EXAMPLE
//INCLUSE JSEND FOR RESPONSE FORMATTING
//http://labs.omniti.com/labs/jsend
include DIR_PLUGINS.'/jsend/Jsend.php';

// SET HEADER FOR JSON
header('Content-type: application/json');

// GETS
// EXAMPLE: http://localhost/api/get/index
if (URI_PART_1 === "get"){

    switch (URI_PART_2) {
        case 'index':
            $data  = array(array('id' => 0,'title'=>'First Example', 'description'=> 'My descrkiption', 'complete'=> true, 'assigned'=> array('id'=>0,'name'=>'jose canseco','image'=>'http://location.img')));
                // $response = Jsend::createFail();
                // $response = Jsend::createError();
                $response = Jsend::createSuccess();
                $response->index = $data;
                echo $response;
            break;
        
        default:
            # code...
            echo URI_PART_2.' not found';
            break;
    }
}

?>
