		</main><!-- eof #main-content -->

		<footer id="global-footer">

		</footer>
	</div>
	<!--[if lt IE 7 ]>
	<script src="/js/plugins/dd_belatedpng.js"></script>
	<script> DD_belatedPNG.fix('img, .png_bg');</script>
	<![endif]-->

	<!-- BEGIN handlebars templates -->

		<?php 
		foreach (glob("js/template/*.tpl") as $filename){
		    include $filename;
		}
		?>
	<!-- END handlebars templates -->

	<script type="text/javascript"> window._app_vars = <?= $settings->app_vars_JSON() ?>; </script>
	
	<?php if ($settings->environment == PROD) { ?>
		<!-- BEGIN: PROD javascript -->
		<script src="/js/evbmaster-min.js" type="text/javascript" charset="utf-8"></script>
		<!-- END: PROD javascript -->
	<?php } else { ?>
		<!-- BEGIN: DEV javascript -->
			<!-- BEGIN: jquery -->
			<script src="/js/jquery/jquery-1.9.1.min.js" type="text/javascript" charset="utf-8"></script>
			<!-- END: jquery -->
			<!-- BEGIN: plugins -->
			<script src="/js/plugins/handlebars-1.0.rc.1.js" type="text/javascript"></script>
			<!-- END: plugins -->
			<!-- BEGIN: app -->
			<script src="/js/master.js" type="text/javascript" charset="utf-8"></script>	
			<script src="/js/main.js" type="text/javascript" charset="utf-8"></script>
			<script src="/js/util.js" type="text/javascript" charset="utf-8"></script>
			<script src="/js/modal.js" type="text/javascript" charset="utf-8"></script>
			<script src="/js/index.js" type="text/javascript" charset="utf-8"></script>
			<!-- END: app -->
		<!-- END: DEV javascript -->
	<?php } ?>

	<script type="text/javascript">	
		<?php 
			if (defined('URI_PART_0')) {
				$nm_space = str_replace("-", "", URI_PART_0);
				echo "CHANGE_ME.main.queue(CHANGE_ME.".$nm_space.".init);";
			} else {
				echo "CHANGE_ME.main.queue(CHANGE_ME.index.init);";
			}
		?>
	</script>


	<script type="text/javascript">
  		var _gaq = _gaq || [];
  		_gaq.push(['_setAccount', '<?= $settings->analytics_id ?>']);
  		_gaq.push(['_trackPageview']);
		
  		(function() {
  		  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  		  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  		  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  		})();
	</script>
</body>
</html>