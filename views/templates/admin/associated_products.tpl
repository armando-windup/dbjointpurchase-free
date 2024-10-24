<div class="form-group">
    <label class="control-label col-lg-3">
        {$module->l('Associated Products')}
    </label>
    <div class="col-lg-9">
        <input type="hidden" name="dbjointpurchase_associated_products" id="dbjointpurchase_associated_products" value="{implode(',', $associated_products)}" />
        <input type="text" id="dbjointpurchase_product_autocomplete" class="form-control" placeholder="{$module->l('Search for products')}" />
        <p class="help-block">
            {$module->l('Select up to 3 products to associate with this product.')}
        </p>
    </div>
</div>

{literal}
<script type="text/javascript">
    $(document).ready(function() {
        var selectedProducts = {/literal}{json_encode($associated_products)}{literal};
        var maxProducts = 3;

        // Initialize the product autocomplete field
        $('#dbjointpurchase_product_autocomplete').tokenInput('index.php?controller=AdminProducts&ajax=1&action=searchProducts&forceJson=1&excludeIds=' + {$id_product} + '&token={$token}', {
            theme: 'facebook',
            preventDuplicates: true,
            tokenLimit: maxProducts,
            prePopulate: selectedProducts.map(function(id) {
                return {id: id, name: ''};
            }),
            onAdd: function(item) {
                updateAssociatedProductsField();
            },
            onDelete: function(item) {
                updateAssociatedProductsField();
            }
        });

        function updateAssociatedProductsField() {
            var tokens = $('#dbjointpurchase_product_autocomplete').tokenInput('get');
            var ids = tokens.map(function(token) { return token.id; });
            $('#dbjointpurchase_associated_products').val(ids.join(','));
        }
    });
</script>
{/literal}